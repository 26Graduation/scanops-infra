# scanops-infra

ScanOps 로컬/EC2 인프라 구성 (Docker Compose)

## 구성 서비스

| 서비스 | 이미지 | 포트 | 설명 |
|--------|--------|------|------|
| zap | ghcr.io/zaproxy/zaproxy:stable | 8090 | OWASP ZAP daemon |
| dvwa | ghcr.io/digininja/dvwa:latest | 4280 | 취약점 실습 대상 |
| dvwa-db | mariadb:10 | - | DVWA 전용 DB |
| postgres | postgres:15 | 5432 | ScanOps 메인 DB |

> ZAP에서 DVWA 스캔 시 내부 URL은 `http://dvwa:80` 사용

## 로컬 실행

```bash
# 1. 환경변수 설정
cp .env.example .env
# .env 파일 열어서 값 입력

# 2. 컨테이너 시작
docker compose up -d

# 3. 상태 확인
docker compose ps

# 4. ZAP API 접근 확인
curl "http://localhost:8090/JSON/core/view/version/?apikey=YOUR_API_KEY"

# 5. DVWA 초기화
# 브라우저에서 http://localhost:4280 접속 → Setup/Reset DB 클릭
```

## 종료

```bash
docker compose down          # 컨테이너만 중지
docker compose down -v       # 컨테이너 + 볼륨 삭제 (DB 초기화)
```

## EC2 배포 시 주의사항

- ZAP 포트(8090)는 백엔드 서버에서만 접근 가능하도록 Security Group 설정
- `api.key` 반드시 강한 값으로 변경
- DVWA는 학습/테스트 환경에만 사용, 외부 공개 금지
