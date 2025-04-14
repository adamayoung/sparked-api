//
//  configureMetrics.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Metrics
import Prometheus

func configureMetrics() {
    let factory = PrometheusMetricsFactory()
    MetricsSystem.bootstrap(factory)
}
