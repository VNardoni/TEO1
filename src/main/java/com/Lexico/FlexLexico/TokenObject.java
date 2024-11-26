package com.Lexico.FlexLexico;

import java.util.Optional;

public record TokenObject(String name, String value, Optional<String> type) {}
