# Changelog

## [2.1.0] - 2026-09-07

### Added
- Port `alphaface_256` from FaceFusion 3.9.0: new 256x256 face swapper (AlphaFace, Non-Commercial, 2026) with arcface_128 warp template, raw embedding (no converter), L2-normalized target blending, 256x256/512x512/768x768/1024x1024 resolutions

## [2.0.6] - 2026-09-07

### Changed
- Bump CUDA from 12.6.3 to 13.0.3 (ubuntu22.04 -> ubuntu24.04) and PyTorch from 2.13.0+cu126 to 2.14.0+cu130
- Update Python dependencies to latest: Pillow 12.3.0, PyYAML 6.0.3, addict 2.4.0, future 1.0.0, lmdb 2.3.0, lpips 0.1.4, numpy 2.5.3, onnxruntime 1.29.0, opencv-python 5.0.0.93, protobuf 7.36.1, scikit-image 0.26.0, scipy 1.18.1, tb-nightly 2.21.0, torch 2.14.0, torchvision 0.29.0, tqdm 4.70.0, yapf 0.43.0, python-dotenv 1.2.3, python-multipart 0.0.32

## [2.0.5] - 2026-08-24

### Changed
- Bump CUDA from 12.4.1 to 12.6.3 and PyTorch from 2.6.0+cu124 to 2.13.0+cu126
- Bump uvicorn requirement from >=0.52.3 to >=0.52.4

## [2.0.4] - 2026-08-17

### Changed
- Bump fastapi requirement from >=0.140.0 to >=0.141.1
- Bump uvicorn requirement from >=0.52.0 to >=0.52.3

## [2.0.3] - 2026-07-27

### Changed
- Bump fastapi requirement from >=0.139.2 to >=0.140.0

## [2.0.2] - 2026-07-16

### Fixed
- Fix ImportError: rename app/queue to app/job_queue to avoid shadowing Python stdlib queue module

## [2.0.1] - 2026-07-16

### Changed
- Renamed project from inswapper-flask-api to FaceSwap API (faceswap-api)
- Updated GitHub repository description and tags

### Fixed
- Fix Dockerfile: clone CodeFormer before running download_models.py to avoid directory conflict
- Fix CI: add missing pytest-asyncio to requirements.txt
- Fix CI: add asyncio_mode = auto to pytest.ini
- Fix CI: mock cv2 in restoration tests to avoid real OpenCV calls

## [2.0.0] - 2026-07-15

### Added
- Migrated from Flask to FastAPI with uvicorn, async lifespan, and auto-generated OpenAPI docs at `/docs`
- VRAM-safe async job queue (asyncio.Queue with single serial worker) — processes one request at a time to prevent GPU OOM
- 13 face swap models: inswapper, simswap, ghost, hififace, hyperswap, blendswap, uniface with per-model metadata
- docker-bake.hcl with provenance and SBOM attestations
- GitHub Actions CI workflow: test, detect changes, build and push to ghcr.io
- Dependabot configuration for pip, Docker, and GitHub Actions
- Enhanced FaceFusion-based swap pipeline: cv2.estimateAffinePartial2D + RANSAC warp, soft-edge box mask paste-back, 4 source preparation strategies, identity blending
- Face selector: 7 sort orders (left-right, right-left, top-bottom, small-large, large-small, best-worst, worst-best), gender filter (male/female), age range filter
- Configurable mask controls: per-edge padding and blur
- Configurable face swap resolution per model
- Lazy model loading with caching — only loads model on first use
- Model download script: downloads all 13 ONNX files, 3 embedding converters, insightface buffalo_l, and 4 CodeFormer weight files
- Comprehensive test suite: 203 tests, zero warnings
- `pytest.ini` and `.coveragerc` with coverage configured by default

### Changed
- License changed from GPL v3 to OpenRAIL-AS (matching FaceFusion)
- `GET /` health endpoint now returns available models and queue depth
- `POST /faceswap` returns `202 Accepted` with a job ID (async queue mode)
- `POST /faceswap/sync` blocks until complete (backward compatible mode)
- Updated Dockerfile: CUDA 12.4.1 base image, PyTorch with CUDA 12.4 wheels, onnxruntime-gpu, models pre-downloaded in build
- Enhanced CodeFormer restoration with graceful GPU error degradation and automatic upscale limiting for large images
- Reorganized into `app/` package with services/routes/models/queue separation

### Removed
- Flask and waitress dependencies
- Old `app.py` and `restoration.py` flat files (replaced by package)

### Fixed
- CodeFormer restoration error handling: gracefully falls back to original crop on GPU errors
