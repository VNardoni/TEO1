package com.Lexico.FlexLexico;

import java.util.ArrayList;

public record RuleObject(Integer ruleNumber, String start, ArrayList<RuleItem> rules) {}
