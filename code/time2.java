import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
public class WhatTime {

    public static void main(String[] args) {
        final ZoneId sydney = ZoneId.of("Australia/Sydney");
        final ZonedDateTime now = ZonedDateTime.now(sydney);
        final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a E, dd MMMM uuuu");
        System.out.println("It is currently: " + formatter.format(now) + " in Sydney, Australia.");
    }

}
