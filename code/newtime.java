import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
public class WhatTime {

    public static void main(String[] args) {
        final DateTimeFormatter f = DateTimeFormatter.ofPattern("h:mm a E, dd MMMM uuuu");
        System.out.println("It is currently: " + f.format(ZonedDateTime.now(ZoneId.of("Australia/Sydney"))) + " in Sydney, Australia.");
    }

}

