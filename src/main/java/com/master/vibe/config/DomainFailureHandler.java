package com.master.vibe.config;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class DomainFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		// 실패로직 핸들링
		String errorMsg = "";
		String userEmail = request.getParameter("username");

		if (exception instanceof BadCredentialsException) {
			errorMsg = "비밀번호를 잘못 입력하셨습니다.";
		} else if (exception instanceof UsernameNotFoundException) {
			errorMsg = "아이디를 잘못입력하셨습니다.";
		} else if (exception instanceof AccountExpiredException) { // 해당 X
			errorMsg = "계정만료";
		} else if (exception instanceof CredentialsExpiredException) { // 해당 X
			errorMsg = "비밀번호만료";
		} else if (exception instanceof DisabledException) {
			errorMsg = "탈퇴회원";
		} else if (exception instanceof LockedException) { // 해당 X
			errorMsg = "계정잠김";
		} else {
			errorMsg = "아이디 혹은 비밀번호를 잘못 입력하셨습니다.";
		}

		errorMsg = URLEncoder.encode(errorMsg, "UTF-8");
		setDefaultFailureUrl("/loginError?error=" + errorMsg + "&username=" + userEmail);
		super.onAuthenticationFailure(request, response, exception);
	}
	
}
