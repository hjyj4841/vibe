package com.master.vibe;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("mapper")
public class VibeApplication {

	public static void main(String[] args) {
		SpringApplication.run(VibeApplication.class, args);
	}
}