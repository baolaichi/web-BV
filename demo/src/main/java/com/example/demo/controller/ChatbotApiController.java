package com.example.demo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import com.example.demo.domain.Appointment;
import com.example.demo.service.AppointmentService;

@RestController
@RequestMapping("/api")
public class ChatbotApiController {

    private static final Logger logger = LoggerFactory.getLogger(ChatbotApiController.class);
    private List<Map.Entry<String, String>> qaPairs;
    private static final double SIMILARITY_THRESHOLD = 0.3; // Giảm ngưỡng để dễ match hơn

    @Autowired
    private AppointmentService appointmentService;

    public ChatbotApiController() {
        loadDataset();
    }

    private void loadDataset() {
        qaPairs = new ArrayList<>();
        try {
            ClassPathResource resource = new ClassPathResource("data/dataset.csv");
            logger.info("Loading dataset from: {}", resource.getURL());
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(resource.getInputStream(), StandardCharsets.UTF_8))) {
                // Skip header
                reader.readLine();
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",", 2);
                    if (parts.length == 2) {
                        String question = parts[0].replaceAll("\"", "").trim();
                        String answer = parts[1].replaceAll("\"", "").trim();
                        qaPairs.add(new AbstractMap.SimpleEntry<>(question, answer));
                    }
                }
                logger.info("Loaded {} QA pairs from dataset", qaPairs.size());
            }
        } catch (Exception e) {
            logger.error("Error loading dataset", e);
            qaPairs = new ArrayList<>();
        }
    }

    private double calculateSimilarity(String s1, String s2) {
        s1 = s1.toLowerCase().trim();
        s2 = s2.toLowerCase().trim();
        
        // Nếu chuỗi giống hệt nhau
        if (s1.equals(s2)) {
            return 1.0;
        }
        
        // Tách thành các từ
        Set<String> words1 = new HashSet<>(Arrays.asList(s1.split("\\s+")));
        Set<String> words2 = new HashSet<>(Arrays.asList(s2.split("\\s+")));
        
        // Tính Jaccard similarity cho các từ
        Set<String> intersection = new HashSet<>(words1);
        intersection.retainAll(words2);
        
        Set<String> union = new HashSet<>(words1);
        union.addAll(words2);
        
        double wordSimilarity = union.isEmpty() ? 0.0 : (double) intersection.size() / union.size();
        
        // Tính character similarity
        Set<Character> chars1 = s1.chars().mapToObj(c -> (char) c).collect(Collectors.toSet());
        Set<Character> chars2 = s2.chars().mapToObj(c -> (char) c).collect(Collectors.toSet());
        
        Set<Character> charIntersection = new HashSet<>(chars1);
        charIntersection.retainAll(chars2);
        
        Set<Character> charUnion = new HashSet<>(chars1);
        charUnion.addAll(chars2);
        
        double charSimilarity = charUnion.isEmpty() ? 0.0 : (double) charIntersection.size() / charUnion.size();
        
        // Kết hợp cả hai độ tương đồng
        return (wordSimilarity * 0.7) + (charSimilarity * 0.3);
    }

    @PostMapping("/chat")
    public ResponseEntity<Map<String, String>> chat(@RequestBody Map<String, String> request) {
        String userMessage = request.get("message");
        if (userMessage == null || userMessage.isEmpty()) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("response", "Error: No message provided");
            return ResponseEntity.badRequest().body(errorResponse);
        }

        try {
            logger.info("Received message: {}", userMessage);
            
            // Find the most similar question
            String bestAnswer = "Xin lỗi, tôi không hiểu câu hỏi của bạn. Vui lòng thử lại.";
            double bestSimilarity = 0.0;
            String bestQuestion = "";

            for (Map.Entry<String, String> qa : qaPairs) {
                double similarity = calculateSimilarity(userMessage, qa.getKey());
                if (similarity > bestSimilarity) {
                    bestSimilarity = similarity;
                    bestAnswer = qa.getValue();
                    bestQuestion = qa.getKey();
                }
            }

            logger.info("Best match - Question: '{}', Similarity: {}, Answer: '{}'", 
                       bestQuestion, bestSimilarity, bestAnswer);

            // Only return the answer if similarity is above threshold
            if (bestSimilarity >= SIMILARITY_THRESHOLD) {
                Map<String, String> response = new HashMap<>();
                response.put("response", bestAnswer);
                return ResponseEntity.ok(response);
            } else {
                Map<String, String> response = new HashMap<>();
                response.put("response", "Xin lỗi, tôi không hiểu câu hỏi của bạn. Vui lòng thử lại.");
                return ResponseEntity.ok(response);
            }

        } catch (Exception e) {
            logger.error("Error processing message", e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("response", "Error processing your message.");
            return ResponseEntity.internalServerError().body(errorResponse);
        }
    }

    @GetMapping("/appointment/status/{id}")
    public ResponseEntity<?> getAppointmentStatus(@PathVariable Long id) {
        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment != null) {
            return ResponseEntity.ok().body(Map.of("status", appointment.getStatus()));
        } else {
            return ResponseEntity.notFound().build();
        }
    }
} 