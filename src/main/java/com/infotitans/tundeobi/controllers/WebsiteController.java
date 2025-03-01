package com.infotitans.tundeobi.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WebsiteController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "Tunde Obi - Official Website");
        return "index";
    }

    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("title", "About Tunde Obi");
        return "about";
    }

    @GetMapping("/books")
    public String books(Model model) {
        model.addAttribute("title", "Books - Tunde Obi");
        return "books";
    }

    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("title", "Contact - Tunde Obi");
        return "contact";
    }

    @PostMapping("/send-message")
    public String sendMessage(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            @RequestParam(value = "newsletter", required = false) boolean newsletter,
            Model model) {
        // Placeholder logic for processing the contact form
        System.out.println("Received message from " + name + " (" + email + ")");
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);
        System.out.println("Newsletter subscription: " + newsletter);

        // Add success message to display on the page
        model.addAttribute("title", "Contact - Tunde Obi");
        model.addAttribute("successMessage", "Your message has been sent successfully!");
        return "contact"; // Return to contact page with success message
    }

    @PostMapping("/subscribe")
    public String subscribe(@RequestParam("email") String email, Model model) {
        // Placeholder logic for newsletter subscription
        System.out.println("Newsletter subscription request from: " + email);

        // Add success message
        model.addAttribute("title", "Contact - Tunde Obi");
        model.addAttribute("successMessage", "Thank you for subscribing to the newsletter!");
        return "contact"; // Return to contact page with success message
    }
}