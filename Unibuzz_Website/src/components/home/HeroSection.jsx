import React, { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowRight, Sparkles, Zap, Globe } from "lucide-react";

const SLIDES = [
  {
    id: 1,
    bg: "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=2070&auto=format&fit=crop",
    title: "WE DON'T JUST ATTEND.",
    subtitle: "WE TAKE OVER.",
    tag: "CAMPUS REVOLUTION",
    color: "ubLime"
  },
  {
    id: 2,
    bg: "https://images.unsplash.com/photo-1523580494863-6f3031224c94?q=80&w=2070&auto=format&fit=crop",
    title: "YOUR SKILLS.",
    subtitle: "VERIFIED ON CHAIN.",
    tag: "SMART PORTFOLIO",
    color: "ubViolet"
  },
  {
    id: 3,
    bg: "https://images.unsplash.com/photo-1531482615713-2afd69097998?q=80&w=2070&auto=format&fit=crop",
    title: "FIND YOUR SQUAD.",
    subtitle: "BUILD YOUR LEGACY.",
    tag: "COMMUNITY FIRST",
    color: "blue-500"
  }
];

const HeroSection = () => {
    const [current, setCurrent] = useState(0);

    useEffect(() => {
        const timer = setInterval(() => {
            setCurrent((prev) => (prev + 1) % SLIDES.length);
        }, 5000);
        return () => clearInterval(timer);
    }, []);

    return (
        <div className="relative h-screen min-h-[700px] w-full overflow-hidden bg-ubBlack">
            {/* Background Slides */}
            <AnimatePresence mode="wait">
                <motion.div
                    key={current}
                    initial={{ scale: 1.1, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    exit={{ opacity: 0 }}
                    transition={{ duration: 1.5 }}
                    className="absolute inset-0 z-0"
                >
                    <div className="absolute inset-0 bg-black/60 z-10" /> {/* Overlay */}
                    <img 
                        src={SLIDES[current].bg} 
                        alt="Hero Background" 
                        className="w-full h-full object-cover"
                    />
                </motion.div>
            </AnimatePresence>

            {/* Scrolling Marquee Background - Gen Z Marketing */}
            <div className="absolute top-1/3 w-full -rotate-6 opacity-10 z-0 pointer-events-none select-none overflow-hidden whitespace-nowrap">
                <motion.div 
                    animate={{ x: ["0%", "-100%"] }} 
                    transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                    className="text-[12rem] font-black text-white leading-none flex gap-8"
                >
                    <span>NO_FOMO</span>
                    <span>REAL_IMPACT</span>
                    <span>LEVEL_UP</span>
                    <span>GO_BIG</span>
                    <span>NO_FOMO</span>
                    <span>REAL_IMPACT</span>
                    <span>LEVEL_UP</span>
                    <span>GO_BIG</span>
                </motion.div>
            </div>

            {/* Content Content */}
            <div className="absolute inset-0 z-20 flex flex-col justify-center items-center text-center px-4">
                <AnimatePresence mode="wait">
                    <motion.div 
                        key={current}
                        initial={{ y: 50, opacity: 0, filter: "blur(10px)" }}
                        animate={{ y: 0, opacity: 1, filter: "blur(0px)" }}
                        exit={{ y: -50, opacity: 0, filter: "blur(10px)" }}
                        transition={{ duration: 0.8, ease: "easeOut" }}
                        className="max-w-5xl"
                    >
                        <div className={`inline-flex items-center gap-2 px-4 py-1 rounded-full border border-white/20 bg-white/5 backdrop-blur-md mb-6 mx-auto`}>
                             <Sparkles size={14} className={`text-${SLIDES[current].color === 'blue-500' ? 'blue-400' : SLIDES[current].color}`} />
                             <span className="text-xs font-bold tracking-widest text-white">{SLIDES[current].tag}</span>
                        </div>

                        <h1 className="text-6xl md:text-9xl font-black italic tracking-tighter text-white mb-2 leading-[0.85] mix-blend-overlay">
                            {SLIDES[current].title}
                        </h1>
                        <h2 className={`text-6xl md:text-9xl font-black italic tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-white to-gray-500 leading-[0.85]`}>
                            {SLIDES[current].subtitle}
                        </h2>
                    </motion.div>
                </AnimatePresence>

                <motion.div 
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 1 }}
                    className="mt-12 flex flex-col md:flex-row gap-6 items-center"
                >
                    <button className="px-10 py-4 bg-ubLime text-ubBlack font-bold text-lg hover:scale-110 active:scale-95 transition-all skew-x-[-10deg] shadow-[5px_5px_0px_0px_#7D39EB]">
                        <div className="skew-x-[10deg] flex items-center gap-2">
                             JOIN THE HYPE <Zap size={20} fill="black" />
                        </div>
                    </button>
                    <button className="px-10 py-4 border border-white/20 text-white font-bold text-lg hover:bg-white/10 transition-all skew-x-[-10deg] backdrop-blur-md">
                         <div className="skew-x-[10deg] flex items-center gap-2">
                             VIEW EVENTS <ArrowRight size={20} />
                        </div>
                    </button>
                </motion.div>
            </div>

            {/* Slide Indicators */}
            <div className="absolute bottom-10 left-1/2 -translate-x-1/2 flex gap-4 z-30">
                {SLIDES.map((_, idx) => (
                    <button 
                        key={idx}
                        onClick={() => setCurrent(idx)}
                        className={`transition-all duration-300 ${current === idx ? 'w-12 bg-ubLime' : 'w-3 bg-white/30 hover:bg-white'} h-1.5 rounded-full`}
                    />
                ))}
            </div>
        </div>
    );
};

export default HeroSection;
