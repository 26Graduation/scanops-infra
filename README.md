# ScanOps 인프라

**현재 Java CPG + LLM 분석 호스트와 기존 QLoRA 모델 경로를 함께 운영하는 구성입니다.**

| 구성 | 역할 | 안내 |
|---|---|---|
| Java 분석 호스트 | Joern CPG + Qwen3.8-Max 앙상블 | [현재 실행 안내](docs/JAVA_DEPLOYMENT.md), [Compose](docker-compose.java-engine.yml) |
| 기존 모델 경로 | Qwen3.5-9B QLoRA / RunPod | [모델·실제 가중치](https://github.com/26Graduation/scanops-model/blob/main/docs/FINETUNED_MODEL.md), [기존 Compose](docker-compose.rebuild.yml) |
| 백엔드·DB | 인증, 언어별 라우팅, 결과 저장 | [백엔드](https://github.com/26Graduation/scanops-backend) |
| ZAP | 웹 URL 동적 분석 | [로컬 테스트 Compose](docker-compose.yml) |
| 프론트 | 요청·진행·취약점 리포트 | [프론트](https://github.com/26Graduation/scanops-frontend) |

## 시작하기

`scanops-model`과 이 저장소를 같은 부모 폴더에 clone한 후 [Java 실행 안내](docs/JAVA_DEPLOYMENT.md)를 따릅니다.
일반 `docker compose up`은 DB/ZAP 테스트 구성이며, 현재 Java 엔진을 시작하려면 `docker-compose.java-engine.yml`을 명시합니다.

Java에는 `SCANOPS_JAVA_MODEL_URL` / `SCANOPS_JAVA_API_KEY`, 기존 비Java에는 `SCANOPS_MODEL_URL` / `SCANOPS_API_KEY`를 사용합니다.
기존 모델 URL을 Java 서버로 덮어쓰지 않습니다.

## 보존 자료

- [2026-09-08 배포 기록](JAVA_CPG_DEPLOYMENT_20260908.md): 당시 검증·제한사항. 과거 명령은 현재 실행 안내로 대체됩니다.
- [기존 온프레미스 안내](README_onprem.md): 2026-08 당시 QLoRA 구성 기록.
- [이전 README](docs/history/README-before-20260914.md): ZAP·Railway 개발 이력.

이번 main 정리는 코드·문서 공개 정리이며 서버를 재배포하지 않습니다.
