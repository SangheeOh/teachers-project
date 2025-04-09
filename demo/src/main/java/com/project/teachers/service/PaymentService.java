package com.project.teachers.service;

import org.springframework.http.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
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
    public Payment verifyAndSavePayment(String impUid, String merchantUid,int reservationNo) {
    	
    	//콘솔 확인
    	System.out.println("🔶 [Service] verifyAndSavePayment 호출");
    	
    	
        // 1. 아임포트 API로 결제 검증 요청
        Payment payment = verifyPayment(impUid);

        if (payment != null && "paid".equals(payment.getStatus())) {
            
        	payment.setMerchantUid(merchantUid);
        	payment.setReservationNo(reservationNo);
        	
        	// 2. 결제 상태가 'paid'이면 DB에 저장
            return savePayment(payment);
        }
        
        //콘솔 확인
        System.out.println("❌ [Service] 결제 상태가 'paid'가 아님");
        return null;  // 결제 검증 실패 시 null 반환
    }

   
    
    // 아임포트 API에서 결제 검증
    private Payment verifyPayment(String impUid) {
        // 1. 아임포트 인증 토큰 요청
        String accessToken = getAccessToken();

        if (accessToken != null) {
        	
        	System.out.println("🔑 apiKey: " + apiKey);
        	System.out.println("🔐 apiSecret: " + apiSecret);

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
                    payment.setAmount((Integer) responseData.get("amount"));
                    payment.setStatus((String) responseData.get("status"));
                    payment.setMethod((String) responseData.get("pay_method"));		  // 🔥 추가됨
                    payment.setPaymentType((String) responseData.get("pg_provider")); // 🔥 추가됨

                    System.out.println("🔍 [Service] 결제 검증 응답: " + responseData);
                    return payment;
                }
            }
        }

        return null;  // 결제 검증 실패 시 null 반환
    }

    
    
    
/*
    // 아임포트 인증 토큰 발급
    private String getAccessToken() {
        
    	System.out.println("🔑 apiKey(getAccessToken까지 도착): " + apiKey);
    	System.out.println("🔐 apiSecret(getAccessToken까지 도착): " + apiSecret);
    	
    	String url = IMP_URL + "/users/getToken";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        //JSON 문자열로 바디 만들기(실패)
        //String jsonBody = String.format("{\"imp_key\":\"%s\", \"imp_secret\":\"%s\"}", apiKey, apiSecret);
        //HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

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

*/
    //새로운 코드
    public String getAccessToken() {
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://api.iamport.kr/users/getToken";

        // 헤더 설정: Content-Type을 application/json으로 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 요청 본문에 담을 데이터 (Map 사용)
        Map<String, String> body = new HashMap<>();
        body.put("imp_key", apiKey);  // 아임포트 API 키
        body.put("imp_secret", apiSecret);  // 아임포트 비밀키

        // HttpEntity 생성, 바디와 헤더를 함께 전달
        HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);

        try {
            // RestTemplate을 사용하여 POST 요청을 보냄
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, request, Map.class);

            // 응답에서 access_token을 추출
            Map responseBody = response.getBody();
            if (responseBody != null) {
                Map responseData = (Map) responseBody.get("response");
                if (responseData != null) {
                    return (String) responseData.get("access_token");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;  // 토큰 발급 실패 시 null 반환
    }
    

    // 결제 정보 DB 저장
    private Payment savePayment(Payment payment) {
    	
    	//콘솔확인
    	System.out.println("💾 [Service] DB 저장 시도, 반드시 이 로그는 찍혀야함!!");
        System.out.println("payment: " + payment);
        
        // Mapper를 사용하여 DB에 결제 정보 저장
        paymentMapper.insertPayment(payment);  // PaymentMapper의 insertPayment 메서드 사용
        
        //콘솔확인
        System.out.println("✅ [Service] DB 저장 완료");
        
        return payment;  // 저장된 Payment 객체 반환
    }
}