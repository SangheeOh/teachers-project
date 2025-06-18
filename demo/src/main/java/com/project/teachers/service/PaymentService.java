package com.project.teachers.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.teachers.entity.Payment;
import com.project.teachers.mapper.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    @Value("${iamport.api.key}")
    private String apiKey;

    @Value("${iamport.api.secret}")
    private String apiSecret;

    private static final String IMP_URL = "https://api.iamport.kr";

    public Payment verifyAndSavePayment(String impUid, String merchantUid, int reservationNo) {
        //System.out.println("[Service] verifyAndSavePayment 호출");
        //System.out.println("impUid(service): " + impUid);

        Payment payment = verifyPayment(impUid);

        if (payment != null && "paid".equals(payment.getStatus())) {
            payment.setMerchantUid(merchantUid);
            payment.setReservationNo(reservationNo);
            return savePayment(payment);
        }

        //System.out.println("[Service] 결제 상태가 'paid'가 아님");
        return null;
    }

    private Payment verifyPayment(String impUid) {
        String accessToken = getAccessToken();

        if (accessToken == null) {
            System.out.println("[Service] 토큰 발급 실패");
            return null;
        }

        //System.out.println("Access Token 발급 성공: " + accessToken);

        String url = IMP_URL + "/payments/" + impUid;
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                Map<String, Object> body = response.getBody();
                //System.out.println("[Service] 결제 검증 응답 바디: " + body);

                Map<String, Object> data = (Map<String, Object>) body.get("response");

                if (data != null && "paid".equals(data.get("status"))) {
                    Payment payment = new Payment();
                    payment.setImpUid((String) data.get("imp_uid"));
                    payment.setAmount((Integer) data.get("amount"));
                    payment.setStatus((String) data.get("status"));
                    payment.setMethod((String) data.get("pay_method"));
                    payment.setPaymentType((String) data.get("pg_provider"));

                    //System.out.println("[Service] 결제 검증 성공: " + data);
                    return payment;
                }
            }
        } catch (Exception e) {
            System.out.println("[Service] 결제 검증 중 오류 발생");
            e.printStackTrace();
        }

        return null;
    }

    public String getAccessToken() {
        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // 동적으로 JSON 생성
            String json = "{\"imp_key\":\"" + apiKey + "\",\"imp_secret\":\"" + apiSecret + "\"}";
            HttpEntity<String> entity = new HttpEntity<>(json, headers);

            ResponseEntity<String> response = restTemplate.postForEntity(
                    IMP_URL + "/users/getToken",
                    entity,
                    String.class
            );

            String responseBody = response.getBody();
            //System.out.println("[AccessToken 응답 본문]: " + responseBody);

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(responseBody);
            JsonNode accessTokenNode = root.path("response").path("access_token");

            if (!accessTokenNode.isMissingNode()) {
                return accessTokenNode.asText();
            } else {
                System.out.println("[Service] access_token 노드 없음");
            }

        } catch (Exception e) {
            System.out.println("[Service] AccessToken 요청 중 예외 발생");
            e.printStackTrace();
        }
        return null;
    }
    
    //db저장
    private Payment savePayment(Payment payment) {
        //System.out.println("[Service] DB 저장 시도");
        paymentMapper.insertPayment(payment);
        //System.out.println("[Service] DB 저장 성공");
        return payment;
    }
}
