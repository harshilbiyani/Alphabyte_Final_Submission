import React, { useEffect, useState } from 'react';
import Navbar from './Navbar';
import HeroSection from './HeroSection';
import CircularEventCarousel from './CircularEventCarousel';
import AboutSection from './AboutSection';
import PulseNetworkSection from './PulseNetworkSection'; 
import { ArrowUp } from 'lucide-react';
import { motion, useScroll, useSpring } from 'framer-motion';

const HomePage = () => {
    const { scrollYProgress } = useScroll();
    const scaleX = useSpring(scrollYProgress, {
        stiffness: 100,
        damping: 30,
        restDelta: 0.001
    });

    const [showTopBtn, setShowTopBtn] = useState(false);

    useEffect(() => {
        const handleScroll = () => {
            if (window.scrollY > 400) setShowTopBtn(true);
            else setShowTopBtn(false);
        };
        window.addEventListener('scroll', handleScroll);
        return () => window.removeEventListener('scroll', handleScroll);
    }, []);

    const scrollToTop = () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    };

    return (
        <div className="bg-ubBlack min-h-screen text-white selection:bg-ubLime selection:text-black font-sans">
            
            {/* Scroll Progress Bar */}
            <motion.div
                className="fixed top-0 left-0 right-0 h-1 bg-ubLime origin-left z-[100]"
                style={{ scaleX }}
            />

            <Navbar />
            
            <main>
                {/* 1. Hero Segment */}
                <HeroSection />
                
                {/* 2. Circular Animation Cards 
                    Added additional margin top to ensure no overlap and clear separation
                */}
                <div id="events" className="relative z-10 mt-20">
                    <CircularEventCarousel /> 
                </div>

                {/* 3. About UniBuzz Segment */}
                <AboutSection />

                {/* 4. Something Creative & Innovative Gen-Z (Pulse Network) */}
                <PulseNetworkSection />
                
                {/* 5. Ending / Final CTA */}
                <section className="py-24 bg-gradient-to-t from-black to-ubDarkGrey relative overflow-hidden">
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-ubViolet/20 rounded-full blur-[120px] pointer-events-none"></div>
                    <div className="max-w-4xl mx-auto px-6 text-center relative z-10">
                        <h2 className="text-5xl md:text-7xl font-bold mb-8 tracking-tighter">
                            Ready to transform <br/> campus culture?
                        </h2>
                        <button className="px-10 py-5 bg-ubLime text-black text-xl font-bold rounded-full hover:scale-105 transition-transform shadow-[0_0_40px_rgba(198,255,51,0.3)] flex items-center gap-3 mx-auto">
                            Launch Your First Event <span className="text-2xl">🚀</span>
                        </button>
                    </div>
                </section>

                <footer className="bg-black py-12 border-t border-white/5">
                    <div className="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center opacity-60">
                         <div className="flex items-center gap-2 mb-4 md:mb-0">
                             {/* Small text logo for footer */}
                             <span className="font-bold text-xl tracking-tight">UniBuzz</span>
                         </div>
                         <div className="text-sm">
                             © 2026 Unified Campus Events Fabric.
                         </div>
                    </div>
                </footer>
            </main>

            {/* Floating Back to Top */}
            <button 
                onClick={scrollToTop}
                className={`fixed bottom-8 right-8 p-3 rounded-full bg-white/10 backdrop-blur-md border border-white/10 hover:bg-ubLime hover:text-black transition-all duration-300 z-40 ${showTopBtn ? 'translate-y-0 opacity-100' : 'translate-y-20 opacity-0'}`}
            >
                <ArrowUp size={24} />
            </button>
        </div>
    );
};

export default HomePage;
