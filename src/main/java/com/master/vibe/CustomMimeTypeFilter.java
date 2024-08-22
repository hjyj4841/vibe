package com.master.vibe;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@Component
public class CustomMimeTypeFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        // 요청된 URI가 ".js"로 끝나면
        if (request.getRequestURI().endsWith(".js")) {
            // MIME 타입을 application/javascript로 설정
            response.setContentType("application/javascript");
        }

        // 필터 체인을 통해 계속 진행
        filterChain.doFilter(request, response);
    }
}