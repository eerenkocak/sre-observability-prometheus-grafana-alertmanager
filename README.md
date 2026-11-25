# SRE Observability Stack: Prometheus, Grafana & Alertmanager (ChatOps Alerting)

[English Documentation](#english-version) | [Turkce Dokumantasyon](#turkce-versiyon)

---

## <a name="english-version"></a>English Version

This repository implements a production-ready **Site Reliability Engineering (SRE) Observability & Alerting Stack** using **Prometheus, Grafana, Alertmanager, Node Exporter, and cAdvisor**. Instead of manual UI configuration, all data sources and custom telemetry dashboards are provisioned declaratively as code, paired with custom **PromQL** alerting rules (`CPU > 80%`, `Memory > 85%`, `InstanceDown`) and **ChatOps** webhook notifications.

### Key SRE, Observability & FinOps Practices

* **Dashboards & Datasources as Code (`grafana/provisioning/`):** Automatically bootstraps the Prometheus datasource and a custom **Production SRE Telemetry & Alerting** dashboard JSON upon container startup—eliminating manual setup.
* **Custom PromQL Alerting Rules (`prometheus/alert_rules.yml`):** Continuously evaluates host and service health, firing critical alerts when CPU utilization exceeds `80%`, memory crosses `85%`, or any monitored target goes down (`up == 0`).
* **Alertmanager & ChatOps Routing (`alertmanager/alertmanager.yml`):** Routes firing alerts to Slack/Discord/PagerDuty webhooks and enforces `inhibit_rules` to suppress noisy warning alerts during active critical incidents (preventing alert fatigue).
* **FinOps & Network Isolation (`docker-compose.yml`):** Enforces strict memory limits (`mem_limit`) across all monitoring containers and isolates telemetry traffic inside a dedicated `monitoring-net` bridge network.

### Project Structure

```text
sre-observability-prometheus-grafana-alertmanager/
|-- prometheus/

|   |-- prometheus.yml       # Scrape targets & Alertmanager integration
|   `-- alert_rules.yml      # Custom PromQL rules (CPU > 80%, Memory > 85%, InstanceDown)
|-- alertmanager/
|   `-- alertmanager.yml     # ChatOps webhook receiver & alert inhibition rules
|-- grafana/
|   `-- provisioning/

|       |-- datasources/
|       |   `-- datasource.yml # Automated Prometheus datasource provisioning
|       `-- dashboards/

|           |-- dashboard.yml  # Dashboard provider configuration
|           `-- sre-dashboard.json # Custom SRE Telemetry & Alerting JSON model
|-- docker-compose.yml       # Full observability stack with FinOps resource caps
|-- .gitignore
`-- README.md
```

---

## <a name="turkce-versiyon"></a>Turkce Versiyon

Bu depo, **Prometheus, Grafana, Alertmanager, Node Exporter ve cAdvisor** kullanilarak insa edilmis produksiyon standartlarinda bir **SRE Gozlem ve Alarm (Observability & Alerting)** mimarisidir. Arayuzden manuel kurulum yapmak yerine tum veri kaynaklari ve ozel telemetri panolari kod olarak (**Provisioning as Code**) yuklenir; ozel **PromQL** kurallari (`CPU > %80`, `RAM > %85`, `InstanceDown`) ile kritik durumlarda **ChatOps** kanallarina anlik bildirim gonderilir.

### One Cikan SRE, Gozlem ve FinOps Pratikleri

* **Kod Olarak Dashboard ve Veri Kaynagi (`grafana/provisioning/`):** Konteynerler ayağa kalktigi an Prometheus veri kaynagini ve ozel **Production SRE Telemetry & Alerting** JSON panosunu otomatik yukler.
* **Ozel PromQL Alarm Kurallari (`prometheus/alert_rules.yml`):** CPU kullanimi `%80` esigini gectiginde, RAM `%85` uzerine ciktiginda veya bir servis dustugunde (`up == 0`) kritik alarm uretir.
* **Alertmanager & ChatOps Yonlendirmesi (`alertmanager/alertmanager.yml`):** Tetiklenen alarmlari Slack/Discord/PagerDuty webhooklarina iletir ve `inhibit_rules` ile kritik alarm aninda dusuk oncelikli uyarilari susturarak alarm yorgunlugunu (alert fatigue) onler.
* **FinOps ve Ag Izolasyonu (`docker-compose.yml`):** Tum izleme konteynerlerine bellek sinirlari (`mem_limit`) uygular ve trafigi ozel `monitoring-net` aginda izole eder.
