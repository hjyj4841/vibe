package com.master.vibe.config;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component(value = "authenticationFailureHandler")
public class DomainFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

	// 실패로직 핸들링

        exception.printStackTrace();

        writePrintErrorResponse(response, exception);
    }

    private void writePrintErrorResponse(HttpServletResponse response, AuthenticationException exception) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();

            Map<String, Object> responseMap = new HashMap<>();

            String message = getExceptionMessage(exception);

            responseMap.put("status", 401);

            responseMap.put("message", message);

            response.getOutputStream().println(objectMapper.writeValueAsString(responseMap));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getExceptionMessage(AuthenticationException exception) {
        if (exception instanceof BadCredentialsException) {
        	System.out.println("비밀번호불일치");
            return "비밀번호불일치";
        } else if (exception instanceof UsernameNotFoundException) {
        	System.out.println("계정없음");
            return "계정없음";
        } else if (exception instanceof AccountExpiredException) {
        	System.out.println("계정만료");
            return "계정만료";
        } else if (exception instanceof CredentialsExpiredException) {
        	System.out.println("비밀번호만료");
            return "비밀번호만료";
        } else if (exception instanceof DisabledException) {
        	System.out.println("계정비활성화");
            return "계정비활성화";
        } else if (exception instanceof LockedException) {
        	System.out.println("계정잠김");
            return "계정잠김";
        } else {
        	System.out.println("확인된 에러가 없습니다.");
            return "확인된 에러가 없습니다.";
        }
    }

}
