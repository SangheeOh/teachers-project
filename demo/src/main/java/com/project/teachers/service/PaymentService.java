package com.project.teachers.service;

import org.springframework.http.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import org.springframework.web.client.RestTemplate;

import com.project.teachers.entity.Payment;
import com.project.teachers.mapper.PaymentMapper;  // PaymentMapper 추가

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;  // PaymentMapper 사용 (Repository -> Mapper로 변경)

    @Value("${iamport.api.key}")  // application.properties에서 아임포트 API 키 불러오기
    private String apiKey;

    @Value("${iamport.api.secret}")  // 아임포트 API 비밀키 불러오기
    private String apiSecret;

    private static final String IMP_URL = "https://api.iamport.kr";  // 아임포트 API URL

    // 결제 검증 후 DB 저장
    public Payment verifyAndSavePayment(String impUid, String merchantUid) {
        // 1. 아임포트 API로 결제 검증 요청
        Payment payment = verifyPayment(impUid);

        if (payment != null && "paid".equals(payment.getStatus())) {
            // 2. 결제 상태가 'paid'이면 DB에 저장
            return savePayment(payment);
        }

        return null;  // 결제 검증 실패 시 null 반환
    }

    // 아임포트 API에서 결제 검증
    private Payment verifyPayment(String impUid) {
        // 1. 아임포트 인증 토큰 요청
        String accessToken = getAccessToken();

        if (accessToken != null) {
            // 2. 인증된 토큰으로 결제 검증 요청
            String url = IMP_URL + "/payments/" + impUid;
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + accessToken);
            HttpEntity<String> entity = new HttpEntity<>(headers);

            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);

            // 3. 응답 결과 처리
            if (responseEntity.getStatusCode() == HttpStatus.OK) {
                Map<String, Object> responseMap = responseEntity.getBody();
                Map<String, Object> responseData = (Map<String, Object>) responseMap.get("response");

                // 결제 성공 여부 확인
                if (responseData != null && "paid".equals(responseData.get("status"))) {
                    // 결제 정보를 Payment 객체에 담아서 반환
                    Payment payment = new Payment();
                    payment.setImpUid(impUid);
                    payment.setMerchantUid((String) responseData.get("merchant_uid"));
                    payment.setAmount(new BigDecimal((Integer) responseData.get("amount")));
                    payment.setStatus((String) responseData.get("status"));

                    return payment;
                }
            }
        }

        return null;  // 결제 검증 실패 시 null 반환
    }

    // 아임포트 인증 토큰 발급
    private String getAccessToken() {
        String url = IMP_URL + "/users/getToken";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("imp_key", apiKey);  // 아임포트 API 키
        requestBody.put("imp_secret", apiSecret);  // 아임포트 비밀키

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            Map<String, Object> responseMap = responseEntity.getBody();
            Map<String, Object> responseData = (Map<String, Object>) responseMap.get("response");

            // 인증 토큰 반환
            if (responseData != null) {
                return (String) responseData.get("access_token");
            }
        }

        return null;  // 인증 실패 시 null 반환
    }

    // 결제 정보 DB 저장
    private Payment savePayment(Payment payment) {
        // Mapper를 사용하여 DB에 결제 정보 저장
        paymentMapper.insertPayment(payment);  // PaymentMapper의 insertPayment 메서드 사용
        return payment;  // 저장된 Payment 객체 반환
    }
}
