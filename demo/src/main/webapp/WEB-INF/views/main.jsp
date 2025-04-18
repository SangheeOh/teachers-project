<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../resources/css/teachers.css">
    <link rel="stylesheet" href="../resources/assets/styles/reset.css">
    <link rel="stylesheet" href="../resources/assets/styles/global.css">
    <link rel="stylesheet" href="../resources/assets/styles/variables.css">
    <link rel="stylesheet" href="../resources/assets/styles/animations.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>

</head>
<body>
    <header>
        <div class="header-wr">
            <div>
                <a  href="/"><img src="../resources/assets/images/teachers/logo3.png"></a>
                <a href="/"><span>전문가 찾기</span></a>
                <a href="/"><span>커뮤니티</span></a>
            </div>
            <div>
                <a href="/gologin"><span>로그인</span></a>
                <a href="/"><span>마이페이지</span></a>
                <a href="/"><span>회원가입</span></a>
                <a href="/"><button class="btn-primary">선생님 지원</button></a>
            </div>
        </div>
    </header>
    <main>
        <!-- Swiper 컨테이너 -->
        <section data-aos="fade-left">
            <div class="swiper mySwiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/main-slide1.png">
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/main-slide4.png">
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/main-slide2.png">
                    </div>
                </div>
                <div class="slide-text"  data-aos="zoom-in">
                    <p><span>방문 퍼스널</span>트레이닝 서비스</p>
                    <p>원하는 장소에서 개인별 맞춤 강사와 운동하세요!</p>
                </div>
                <a href="/trainer" class="btn-primary start-btn"><button>시작하기</button></a>
                <div class="swiper-pagination"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </section>

        <section class="icon-area" data-aos="fade-up">
            <a href="/"><img src="../resources/assets/images/teachers/symbols1.png"><span>체력강화</span></a>
            <a href="/"><img src="../resources/assets/images/teachers/symbols2.png"><span>다이어트</span></a>
            <a href="/"><img src="../resources/assets/images/teachers/symbols3.png"><span>요가명상</span></a>
            <a href="/"><img src="../resources/assets/images/teachers/symbols4.png"><span>만성통증/재활운동</span></a>
            <a href="/"><img src="../resources/assets/images/teachers/symbols5.png"><span>산전후운동</span></a>
            <a href="/"><img src="../resources/assets/images/teachers/symbols6.png"><span>체형교정/가벼운통증</span></a>
        </section>

        <section class="hot-area" data-aos="fade-up">
            <div class="title-wr">
                <div>
                    <span class="title">인기 티쳐</span>
                    <img src="../resources/assets/images/teachers/ico-purpleheart.png">
                    <button type="button" class="ico-map">전국</button>
                </div>
                <a href="/"  class="right-area">
                    <span>전체보기 <i class="fa-solid fa-chevron-right"></i></span>
                </a>
            </div>
            <!-- 새로운 슬라이드 (하단 추가) -->
            <div class="swiper mySwiper2" data-aos="fade-up">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide2.png">
                        <div>
                            <span>요가</span>
                            <p>건강한 출산과 산 후 회복을 위한 요가</p>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide5.png">
                        <div>
                            <span>필라테스</span>
                            <p>365일 즐기며 힘있고 부드러운 몸 만들기</p>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide1.png">
                        <div>
                            <span>요가</span>
                            <p>힘있고 부드러운 몸 만들기 요가</p>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide6.png">
                        <div>
                            <span>헬스</span>
                            <p>힘있고 부드러운 몸 만들기 요가</p>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide3.png">
                        <div>
                            <span>필라테스</span>
                            <p>365일 즐기며 다이어트 지속하기</p>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <img src="../resources/assets/images/teachers/sub-slide4.png">
                        <div>
                            <span>요가</span>
                            <p>힘있고 부드러운 몸 만들기 요가</p>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
        </section>
        <div class="main-banner" data-aos="fade-up">
            <img src="../resources/assets/images/teachers/logo4.png" alt="main background logo" data-aos="zoom-in">
            <p class="font-48 mt-40">방문 퍼스널 트레이닝 서비스</p>
            <p class="font-32">원하는 장소에서 개인별 맞춤 강사와 운동하세요 !</p>
        </div>

        <section class="hot-area">
            <div class="title-wr">
                <div>
                    <span class="title">다이어트 운동 전문가 찾기</span>
                    <img src="../resources/assets/images/teachers/ico-purpleheart.png">
                </div>
                <a href="/"  class="right-area">
                    <span>전체보기 <i class="fa-solid fa-chevron-right"></i></span>
                </a>
            </div>
            <!-- 새로운 슬라이드 (하단 추가) -->
            <div class="card-list-wrapper" data-aos="fade-up">
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide2.png">
                    <div>
                        <span>요가</span>
                        <p>건강한 출산과 산 후 회복을 위한 요가</p>
                    </div>
                </div>
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide5.png">
                    <div>
                        <span>필라테스</span>
                        <p>365일 즐기며 힘있고 부드러운 몸 만들기</p>
                    </div>
                </div>
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide1.png">
                    <div>
                        <span>요가</span>
                        <p>힘있고 부드러운 몸 만들기 요가</p>
                    </div>
                </div>
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide6.png">
                    <div>
                        <span>헬스</span>
                        <p>힘있고 부드러운 몸 만들기 요가</p>
                    </div>
                </div>
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide3.png">
                    <div>
                        <span>필라테스</span>
                        <p>365일 즐기며 다이어트 지속하기</p>
                    </div>
                </div>
                <div class="card">
                    <img src="../resources/assets/images/teachers/sub-slide4.png">
                    <div>
                        <span>요가</span>
                        <p>힘있고 부드러운 몸 만들기 요가</p>
                    </div>
                </div>
            </div>
        </section>
    </main>






    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        const swiper = new Swiper(".mySwiper", {
            // loop: true,
            autoplay: {
                delay: 15000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });

        const swiper2 = new Swiper(".mySwiper2", {
            slidesPerView: 4, 
            spaceBetween: 20,
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });

        AOS.init({
            duration: 2000, 
        });


        gsap.registerPlugin(ScrollTrigger);

        gsap.from(".slide-up", {
        opacity: 0,
        y: 20,
        duration: 1,
        scrollTrigger: {
            trigger: ".slide-up",
            start: "top 80%",
            toggleActions: "play none none none",
        },
        });
    </script>
</body>
</html>