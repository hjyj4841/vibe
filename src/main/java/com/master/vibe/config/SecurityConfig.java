package com.master.vibe.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		return http
				.csrf(csrf -> csrf.disable())
				.formLogin(login ->
					login.loginPage("/login")
					.defaultSuccessUrl("/", true)
//					.failureForwardUrl("/loginError")
					.failureHandler(new DomainFailureHandler())
					.permitAll())
				.logout(logout ->
					logout.logoutUrl("/logout")
					.logoutSuccessUrl("/")
					.permitAll())
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
				.authorizeHttpRequests(authorize ->
					authorize
						// .requestMatchers("/mypage").authenticated() // 회원만 접속할 수 있는 주소가 있다면 추가
						.anyRequest().permitAll())
				.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
}
