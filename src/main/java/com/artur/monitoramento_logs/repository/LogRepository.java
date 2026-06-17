package com.artur.monitoramento_logs.repository;

import com.artur.monitoramento_logs.entity.Log;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LogRepository extends JpaRepository<Log, Long> {
}