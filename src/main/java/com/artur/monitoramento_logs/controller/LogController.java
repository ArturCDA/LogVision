package com.artur.monitoramento_logs.controller;

import com.artur.monitoramento_logs.entity.Log;
import com.artur.monitoramento_logs.service.LogService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/logs")
@CrossOrigin("*")
public class LogController {

    private final LogService service;

    public LogController(LogService service) {
        this.service = service;
    }

    @PostMapping
    public Log salvar(@RequestBody Log log) {
        Log logSalvo = service.salvar(log);
        return logSalvo;
    }

    @GetMapping
    public List<Log> listar() {
        return service.listar();
    }
}