package com.artur.monitoramento_logs.service;

import com.artur.monitoramento_logs.entity.Log;
import com.artur.monitoramento_logs.repository.LogRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class LogService {

    private final LogRepository repository;

    public LogService(LogRepository repository) {
        this.repository = repository;
    }

    public Log salvar(Log log) {
        log.setTimestamp(LocalDateTime.now());
        return repository.save(log);
    }

    public List<Log> listar() {
        return repository.findAll();
    }
}