package com.example.restservice;

import java.util.concurrent.atomic.AtomicLong;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;

@RestController
public class GreetingController {

	private static final String template = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();
	@Value("${defaultGreeting}")
	private String defaultGreeting;

	@GetMapping("/greeting")
	public Greeting greeting(@RequestParam(value = "name", required=false) String name) {
		if (name == null) {
			name = defaultGreeting;
		}
		return new Greeting(counter.incrementAndGet(), String.format(template, name));
	}
}