package com.Lexico.FlexLexico;

import java.util.Optional;

public class TokenObject {

    private String name;
    private String value;
    private Optional<String> type;

    public TokenObject(String name, String value, Optional<String> type) {
        this.name = name;
        this.value = value;
        this.type = type;
    }

    public String name() {
        return name;
    }

    public String value() {
        return value;
    }

    public Optional<String> type() {
        return type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public void setType(Optional<String> type) {
        this.type = type;
    }
}