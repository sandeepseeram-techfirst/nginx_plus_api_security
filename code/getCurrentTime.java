import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
public class WhatTime {

    public static void main(String[] args) {
        System.out.println("It is currently: " + getCurrentTime("Australia/Sydney") + " in Sydney, Australia.");
    }

    private static String getCurrentTime(String zoneId) {
      final ZoneId locality = ZoneId.of(zoneId);
      final ZonedDateTime now = ZonedDateTime.now(locality);
      final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a E, dd MMMM uuuu");

      return formatter.format(now);
    }
}

