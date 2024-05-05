package com.RazorpayGateway.controller;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

@Controller
public class PaymentController {

	@RequestMapping("/")
	public String home() {
		System.out.println("Start home..");
		return "home";
	}

	@PostMapping("/create_order")
	@ResponseBody
	public String createOrder(@RequestBody Map<String, Object> data) throws Exception {
		int amt = Integer.parseInt(data.get("amount").toString());
		String key = "myRazorpay_Key";
		String secret = "myRazorpay_Secret";

		RazorpayClient razorpayClient = new RazorpayClient(key, secret);

		JSONObject options = new JSONObject();
		options.put("amount", amt * 100); // in paise
		options.put("currency", "INR");
		options.put("receipt", "txn_123456");

		Order order = razorpayClient.orders.create(options);
		// Rahul
		// you can store Order information in DB also..

		return order.toString();
	}
}
