# scanops-infra

ScanOps 인프라 — Docker Compose (로컬) + Railway (ZAP 배포)

## 구성

| 서비스 | 이미지 | 포트 | 배포 |
|--------|--------|------|------|
| ZAP | ghcr.io/zaproxy/zaproxy:stable | 8090 | Railway |
| DVWA | ghcr.io/digininja/dvwa:latest | 4280 | 로컬 전용 |
| dvwa-db | mariadb:10 | - | 로컬 전용 |
| postgres | postgres:15 | 5433 | Railway 플러그인 |

---

## 로컬 실행 (docker compose)

```bash
cp .env.example .env
docker compose up -d

# ZAP API 확인
curl "http://localhost:8090/JSON/core/view/version/"

# DVWA 초기화
# 브라우저 → http://localhost:4280 → Setup/Reset DB 클릭

# ZAP → DVWA 내부 스캔 URL
http://dvwa:80
```

### 개별 서비스만 올리기

```bash
docker compose up postgres -d       # DB만
docker compose up zap dvwa -d      # 스캔 환경만
```

### 종료

```bash
docker compose down        # 컨테이너 중지
docker compose down -v     # 컨테이너 + 볼륨 전체 삭제
```

---

## Railway ZAP 배포

ZAP은 `Dockerfile.zap`을 사용해 Railway에 별도 서비스로 배포합니다.

### 배포 방법

1. [railway.app](https://railway.app) → 기존 Project → **Add Service**
2. **GitHub Repo** → `scanops-infra` 선택
3. Settings → **Dockerfile Path**: `Dockerfile.zap`
4. Variables 탭:
   ```
   (없음 — api.disablekey=true 사용)
   ```
5. Deploy → 도메인 확인: `https://scanops-zap.up.railway.app`

> `Dockerfile.dvwa`는 Railway 무료티어 메모리 부족으로 **로컬 전용**

---

## ZAP API 주요 엔드포인트

```
# 버전 확인
GET /JSON/core/view/version/

# Spider 스캔 시작
GET /JSON/spider/action/scan/?url=http://target

# Active 스캔 시작
GET /JSON/ascan/action/scan/?url=http://target&recurse=true

# 알럿 조회
GET /JSON/core/view/alerts/?baseurl=http://target
```

---

## 보안 주의사항

- ZAP은 반드시 **스캔 동의를 받은 대상**에만 사용
- Railway 배포 시 ZAP 포트는 Railway 내부 네트워크로만 통신 (백엔드 → ZAP)
- DVWA는 학습/테스트 환경 전용, 외부 공개 절대 금지
