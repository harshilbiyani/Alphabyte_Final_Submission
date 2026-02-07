import React, { useRef, useState, useEffect } from 'react';
import { motion, useScroll, useTransform, useSpring, useMotionValue, useMotionTemplate } from 'framer-motion';
import { 
    Zap, Globe, Cpu, Activity, Share2, Layers, 
    ArrowRight, Terminal, Wifi, Database 
} from 'lucide-react';
import Navbar from './Navbar';

// --- VISUAL ASSETS ---
const GRID_PATTERN = "https://grainy-gradients.vercel.app/noise.svg"; // Noise texture

const AboutPage = () => {
  const containerRef = useRef(null);
  const mouseX = useMotionValue(0);
  const mouseY = useMotionValue(0);

  // Global Mouse Tracking for Spotlight
  const handleMouseMove = ({ currentTarget, clientX, clientY }) => {
    const { left, top } = currentTarget.getBoundingClientRect();
    mouseX.set(clientX - left);
    mouseY.set(clientY - top);
  };

  return (
    <div 
        ref={containerRef} 
        onMouseMove={handleMouseMove}
        className="bg-[#030303] min-h-screen text-white overflow-x-hidden font-sans selection:bg-ubLime selection:text-black"
    >
      <Navbar />

      {/* --- HERO: THE DIGITAL NERVOUS SYSTEM --- */}
      <SpotlightHero mouseX={mouseX} mouseY={mouseY} />

      {/* --- SECTION 2: SYNAPTIC SCROLLER --- */}
      <InfiniteMarquee />

      {/* --- SECTION 3: CHAOS TO ORDER (Mission) --- */}
      <ChaosToOrderSection />

      {/* --- SECTION 4: HEATMAP OF HYPE --- */}
      <HeatmapGlobeSection />

      {/* --- SECTION 5: TEAM (DECONSTRUCTED) --- */}
      <TeamGlitchSection />
      
      {/* --- FOOTER CTA --- */}
      <FooterCTA />

    </div>
  );
};

// ------------------------------------------------------------------
// 1. SPOTLIGHT HERO: Reveals the grid network
// ------------------------------------------------------------------
const SpotlightHero = ({ mouseX, mouseY }) => {
    const bg = useMotionTemplate`radial-gradient(600px circle at ${mouseX}px ${mouseY}px, rgba(198, 255, 51, 0.15), transparent 80%)`;
    
    return (
        <section className="relative h-screen flex flex-col items-center justify-center overflow-hidden">
            {/* Base Grid */}
            <div className="absolute inset-0 bg-[linear-gradient(to_right,#80808012_1px,transparent_1px),linear-gradient(to_bottom,#80808012_1px,transparent_1px)] bg-[size:24px_24px]"></div>
            
            {/* The Spotlight Layer */}
            <motion.div 
                className="absolute inset-0 pointer-events-none"
                style={{ background: bg }}
            />

            <div className="relative z-10 text-center px-4 max-w-5xl mx-auto">
                <motion.div
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 1, ease: "anticipate" }}
                    className="mb-6 inline-flex items-center gap-2 px-4 py-2 rounded-full border border-ubLime/30 bg-ubLime/5 backdrop-blur-md"
                >
                    <div className="w-2 h-2 bg-ubLime rounded-full animate-ping" />
                    <span className="text-ubLime font-mono text-xs tracking-widest uppercase">System Online // v.2.4</span>
                </motion.div>

                <h1 className="text-7xl md:text-9xl font-black tracking-tighter leading-none mb-6 mix-blend-color-dodge">
                    DIGITAL <br />
                    <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime via-white to-ubViolet animate-gradient-x">SYNAPSE</span>
                </h1>

                <p className="text-gray-400 text-xl md:text-2xl max-w-2xl mx-auto font-light leading-relaxed">
                    We aren't just a platform. We are the <span className="text-white font-bold">high-speed network</span> wiring 
                    campus culture to the future.
                </p>
            </div>

            {/* Scroll Trigger */}
            <motion.div 
                animate={{ y: [0, 10, 0], opacity: [0.5, 1, 0.5] }}
                transition={{ duration: 2, repeat: Infinity }}
                className="absolute bottom-10"
            >
                <ArrowRight className="rotate-90 text-ubLime" size={32} />
            </motion.div>
        </section>
    );
};

// ------------------------------------------------------------------
// 2. INFINITE MARQUEE: SCROLLING TEXT
// ------------------------------------------------------------------
const InfiniteMarquee = () => {
    return (
        <div className="py-12 bg-ubLime overflow-hidden rotate-[-2deg] scale-110 border-y-4 border-black">
            <motion.div 
                animate={{ x: ["0%", "-50%"] }}
                transition={{ duration: 10, repeat: Infinity, ease: "linear" }}
                className="flex gap-12 whitespace-nowrap text-black font-black text-6xl md:text-8xl tracking-tighter uppercase"
            >
                {[...Array(4)].map((_, i) => (
                    <React.Fragment key={i}>
                        <span>Connect</span> <span className="text-white stroke-black" style={{WebkitTextStroke: "2px black"}}>Collaborate</span> <span>Create</span> <span className="text-white" style={{WebkitTextStroke: "2px black"}}>Disrupt</span>
                    </React.Fragment>
                ))}
            </motion.div>
        </div>
    );
};

// ------------------------------------------------------------------
// 3. CHAOS TO ORDER: UI ASSEMBLES ON SCROLL
// ------------------------------------------------------------------
const ChaosToOrderSection = () => {
    const ref = useRef(null);
    const { scrollYProgress } = useScroll({ target: ref, offset: ["start end", "center center"] });
    
    // Elements flying in from chaos
    const xLeft = useTransform(scrollYProgress, [0, 1], [-500, 0]);
    const xRight = useTransform(scrollYProgress, [0, 1], [500, 0]);
    const rotate = useTransform(scrollYProgress, [0, 1], [45, 0]);
    const scale = useTransform(scrollYProgress, [0, 1], [0.5, 1]);
    const opacity = useTransform(scrollYProgress, [0, 0.5], [0, 1]);

    return (
        <section ref={ref} className="py-40 px-6 relative overflow-hidden">
            <div className="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-20 items-center">
                
                {/* Text Content */}
                <div className="order-2 lg:order-1 relative z-10">
                    <h2 className="text-5xl md:text-7xl font-black tracking-tighter mb-8 leading-[0.9]">
                        ORDER FROM <br /> 
                        <span className="text-ubViolet">CHAOS</span>.
                    </h2>
                    <p className="text-gray-400 text-lg leading-relaxed mb-8 border-l-2 border-ubLime pl-6">
                        Campuses are messy. Events clash. Sponsors are lost. Talent is hidden.
                        UniBuzz acts as the <strong>Operating System</strong> that defragments the experience.
                    </p>
                    <div className="flex gap-4">
                        <FeatureBadge icon={Share2} text="Unified Comms" />
                        <FeatureBadge icon={Database} text="Central Data" />
                        <FeatureBadge icon={Wifi} text="Real-time Sync" />
                    </div>
                </div>

                {/* The "Chaos" Visual */}
                <div className="relative h-[500px] w-full flex items-center justify-center order-1 lg:order-2 perspective-[1000px]">
                    {/* The "Core" Card */}
                    <motion.div 
                        style={{ scale, rotateZ: rotate, opacity }}
                        className="relative z-20 w-80 h-96 bg-[#0A0A0A] border border-white/20 rounded-3xl p-6 shadow-2xl flex flex-col justify-between"
                    >
                         <div className="w-12 h-12 bg-ubLime rounded-full flex items-center justify-center">
                             <Zap className="text-black" />
                         </div>
                         <div className="space-y-2">
                             <div className="h-2 w-24 bg-gray-800 rounded-full"></div>
                             <div className="h-2 w-16 bg-gray-800 rounded-full"></div>
                             <h3 className="text-3xl font-bold text-white mt-4">Unified.</h3>
                         </div>
                    </motion.div>

                    {/* Flying Shard 1 */}
                    <motion.div 
                        style={{ x: xLeft, y: -50, rotate: -15, opacity }}
                        className="absolute z-10 top-10 left-0 w-48 h-32 bg-ubViolet/20 border border-ubViolet/50 rounded-2xl backdrop-blur-md p-4"
                    >
                        <Terminal size={24} className="text-ubViolet mb-2" />
                        <div className="text-xs font-mono text-ubViolet">/// EVENT_LOGS</div>
                    </motion.div>

                    {/* Flying Shard 2 */}
                    <motion.div 
                        style={{ x: xRight, y: 100, rotate: 15, opacity }}
                        className="absolute z-10 bottom-20 right-0 w-56 h-40 bg-ubLime/10 border border-ubLime/50 rounded-2xl backdrop-blur-md p-4"
                    >
                        <Activity size={24} className="text-ubLime mb-2" />
                        <div className="text-xs font-mono text-ubLime">/// METRICS_API</div>
                    </motion.div>
                </div>
            </div>
        </section>
    );
};

// ------------------------------------------------------------------
// 4. HEATMAP OF HYPE: INTERACTIVE GLOBAL ACTIVITY
// ------------------------------------------------------------------
const HeatmapGlobeSection = () => {
    return (
        <section className="py-32 px-6 bg-[#030303] relative overflow-hidden flex flex-col items-center">
            
             {/* Header */}
             <div className="relative z-20 text-center mb-16">
                 <div className="flex items-center justify-center gap-3 mb-4">
                     <span className="relative flex h-3 w-3">
                       <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-ubLime opacity-75"></span>
                       <span className="relative inline-flex rounded-full h-3 w-3 bg-ubLime"></span>
                     </span>
                     <span className="text-ubLime font-mono text-xs tracking-[0.3em] uppercase font-bold">Live Global Activity</span>
                 </div>
                <h2 className="text-5xl md:text-7xl font-black uppercase tracking-tighter text-white">
                    Worldwide <span className="text-transparent bg-clip-text bg-gradient-to-br from-ubLime to-cyan-400">HYPE</span>
                </h2>
            </div>
            
            {/* 3D GLOBE CONTAINER */}
            <div className="relative w-[500px] h-[500px] md:w-[700px] md:h-[700px] group perspective-[1000px]">
                
                {/* GLOBAL TEXTURE SPHERE */}
                <div className="absolute inset-0 rounded-full bg-black shadow-[ inset_20px_0_100px_40px_rgba(0,0,0,1) ] z-10 border border-white/5 overflow-hidden">
                    {/* The Scrolling Map Texture */}
                    <div 
                        className="w-[200%] h-full absolute top-0 left-0 opacity-40 mix-blend-screen"
                        style={{
                            backgroundImage: "url('https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Equirectangular_projection_SW.jpg/2560px-Equirectangular_projection_SW.jpg')",
                            backgroundSize: "50% 100%", // Fit height, repeat width
                            filter: "grayscale(100%) invert(1) brightness(2) contrast(2)", // Make it dark neon style
                        }}
                    >
                        <motion.div 
                            animate={{ x: ["0%", "-50%"] }}
                            transition={{ duration: 30, ease: "linear", repeat: Infinity }}
                            className="w-full h-full"
                        />
                    </div>
                    
                    {/* Shading Overlay (Lens Effect) */}
                    <div className="absolute inset-0 rounded-full bg-[radial-gradient(circle_at_30%_30%,rgba(255,255,255,0.05),transparent_60%,rgba(0,0,0,0.8)_100%)] pointer-events-none"></div>
                </div>

                {/* ATMOSPHERE GLOW */}
                <div className="absolute -inset-10 rounded-full bg-cyan-400/5 blur-[80px] -z-10 animate-pulse-slow"></div>

                {/* ORBITAL RINGS */}
                <div className="absolute inset-0 rounded-full border border-white/5 rotate-12 scale-125 z-0"></div>
                <div className="absolute inset-0 rounded-full border border-white/5 -rotate-12 scale-110 z-0"></div>

                {/* --- CONNECTED STAT CARDS (The Pop-ups) --- */}
        
                {/* SVG Lines Connector Layer */}
                <div className="absolute inset-0 pointer-events-none hidden md:block z-20">
                    <svg className="w-full h-full">
                        {/* Left Side Lines */}
                        <line x1="20%" y1="10%" x2="40%" y2="40%" stroke="#84cc16" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="15%" y1="35%" x2="35%" y2="45%" stroke="#22d3ee" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="15%" y1="65%" x2="35%" y2="55%" stroke="#a855f7" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="20%" y1="90%" x2="40%" y2="60%" stroke="#22d3ee" strokeWidth="1" strokeOpacity="0.3" />

                        {/* Right Side Lines */}
                        <line x1="80%" y1="10%" x2="60%" y2="40%" stroke="#a855f7" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="85%" y1="35%" x2="65%" y2="45%" stroke="#f97316" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="85%" y1="65%" x2="65%" y2="55%" stroke="#84cc16" strokeWidth="1" strokeOpacity="0.3" />
                        <line x1="80%" y1="90%" x2="60%" y2="60%" stroke="#f97316" strokeWidth="1" strokeOpacity="0.3" />
                    </svg>
                </div>

                {/* 1. TOP LEFT: Hackathons */}
                <motion.div 
                    initial={{ opacity: 0, x: -50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.2 }}
                    className="absolute -top-12 left-4 md:-left-24 w-64 bg-zinc-900/80 backdrop-blur-md border border-lime-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(163,230,53,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">🚀</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">500+</h3>
                        <p className="text-xs text-lime-400 font-bold uppercase tracking-wider">Hackathons</p>
                        <p className="text-xs text-zinc-400 mt-1">Launched globally.</p>
                        </div>
                    </div>
                </motion.div>

                {/* 2. MID-TOP LEFT: Startups (NEW) */}
                <motion.div 
                    initial={{ opacity: 0, x: -50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.3 }}
                    className="absolute top-[22%] left-4 md:-left-32 w-64 bg-zinc-900/80 backdrop-blur-md border border-cyan-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(34,211,238,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">🦄</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">85+</h3>
                        <p className="text-xs text-cyan-400 font-bold uppercase tracking-wider">Startups</p>
                        <p className="text-xs text-zinc-400 mt-1">Incubated by students.</p>
                        </div>
                    </div>
                </motion.div>

                {/* 3. MID-BOTTOM LEFT: Mentorship (NEW) */}
                <motion.div 
                    initial={{ opacity: 0, x: -50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.4 }}
                    className="absolute bottom-[22%] left-4 md:-left-32 w-64 bg-zinc-900/80 backdrop-blur-md border border-purple-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(168,85,247,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">🧠</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">12k+</h3>
                        <p className="text-xs text-purple-400 font-bold uppercase tracking-wider">Mentorship Hrs</p>
                        <p className="text-xs text-zinc-400 mt-1">Alumni guidance.</p>
                        </div>
                    </div>
                </motion.div>

                {/* 4. BOTTOM LEFT: Funds */}
                <motion.div 
                    initial={{ opacity: 0, x: -50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.5 }}
                    className="absolute -bottom-12 left-4 md:-left-24 w-64 bg-zinc-900/80 backdrop-blur-md border border-cyan-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(34,211,238,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">💎</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">$2M+</h3>
                        <p className="text-xs text-cyan-400 font-bold uppercase tracking-wider">Spirit Fund</p>
                        <p className="text-xs text-zinc-400 mt-1">For creators.</p>
                        </div>
                    </div>
                </motion.div>


                {/* 5. TOP RIGHT: Events */}
                <motion.div 
                    initial={{ opacity: 0, x: 50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.2 }}
                    className="absolute -top-12 right-4 md:-right-24 w-64 bg-zinc-900/80 backdrop-blur-md border border-purple-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(168,85,247,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">⚡</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">15k+</h3>
                        <p className="text-xs text-purple-400 font-bold uppercase tracking-wider">Live Events</p>
                        <p className="text-xs text-zinc-400 mt-1">Concerts to code.</p>
                        </div>
                    </div>
                </motion.div>
                
                {/* 6. MID-TOP RIGHT: Commits (NEW) */}
                <motion.div 
                    initial={{ opacity: 0, x: 50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.3 }}
                    className="absolute top-[22%] right-4 md:-right-32 w-64 bg-zinc-900/80 backdrop-blur-md border border-orange-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(249,115,22,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">💻</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">2.4M</h3>
                        <p className="text-xs text-orange-400 font-bold uppercase tracking-wider">Code Commits</p>
                        <p className="text-xs text-zinc-400 mt-1">Shipped this sem.</p>
                        </div>
                    </div>
                </motion.div>

                {/* 7. MID-BOTTOM RIGHT: Badges (NEW) */}
                <motion.div 
                    initial={{ opacity: 0, x: 50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.4 }}
                    className="absolute bottom-[22%] right-4 md:-right-32 w-64 bg-zinc-900/80 backdrop-blur-md border border-lime-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(163,230,53,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">🏆</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">850k</h3>
                        <p className="text-xs text-lime-400 font-bold uppercase tracking-wider">Skill Badges</p>
                        <p className="text-xs text-zinc-400 mt-1">Earned by users.</p>
                        </div>
                    </div>
                </motion.div>

                {/* 8. BOTTOM RIGHT: Partners */}
                <motion.div 
                    initial={{ opacity: 0, x: 50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.5 }}
                    className="absolute -bottom-12 right-4 md:-right-24 w-64 bg-zinc-900/80 backdrop-blur-md border border-orange-500/30 p-4 rounded-xl shadow-[0_0_20px_rgba(249,115,22,0.1)] z-30"
                >
                    <div className="flex items-start gap-4">
                        <div className="text-3xl">🤝</div>
                        <div>
                        <h3 className="text-2xl font-black text-white font-mono">120+</h3>
                        <p className="text-xs text-orange-400 font-bold uppercase tracking-wider">Beta Chapters</p>
                        <p className="text-xs text-zinc-400 mt-1">Tier-1 Institutes.</p>
                        </div>
                    </div>
                </motion.div>
            </div>

            {/* LIVE FEED UNDER GLOBE */}
            <div className="mt-12 flex gap-8 items-center justify-center opacity-60">
                 <div className="text-center">
                     <div className="text-3xl font-bold text-white tabular-nums">24,592</div>
                     <div className="text-[10px] uppercase font-mono text-gray-500 tracking-wider">Active Nodes</div>
                 </div>
                 <div className="h-8 w-[1px] bg-white/20"></div>
                 <div className="text-center">
                     <div className="text-3xl font-bold text-ubLime tabular-nums">1.2s</div>
                     <div className="text-[10px] uppercase font-mono text-gray-500 tracking-wider">Avg Latency</div>
                 </div>
            </div>
        </section>
    );
};

// --- DATA VIZ HELPERS ---

const TrafficBar = ({ index }) => {
    return (
        <motion.div
            initial={{ height: "10%" }}
            animate={{ height: ["10%", `${Math.random() * 80 + 20}%`, "10%"] }}
            transition={{ 
                duration: Math.random() * 2 + 1, 
                repeat: Infinity, 
                ease: "easeInOut",
                delay: index * 0.05 
            }}
            className="flex-1 bg-gradient-to-t from-ubLime/10 to-ubLime rounded-t-sm opacity-60 hover:opacity-100 transition-opacity"
        />
    );
};

const CircleProgress = ({ percentage, color }) => {
    const radius = 40;
    const circumference = 2 * Math.PI * radius;
    const offset = circumference - (percentage / 100) * circumference;

    return (
        <svg className="w-full h-full transform -rotate-90">
            <circle cx="50%" cy="50%" r={radius} stroke="rgba(255,255,255,0.1)" strokeWidth="8" fill="transparent" />
            <motion.circle 
                initial={{ strokeDashoffset: circumference }}
                whileInView={{ strokeDashoffset: offset }}
                transition={{ duration: 2, ease: "easeOut" }}
                cx="50%" cy="50%" r={radius} 
                stroke={color} 
                strokeWidth="8" 
                fill="transparent" 
                strokeDasharray={circumference} 
                strokeLinecap="round"
            />
        </svg>
    );
};

// ------------------------------------------------------------------
// 5. TEAM GLITCH: BOLD TYPOGRAPHY
// ------------------------------------------------------------------
const TeamGlitchSection = () => {
    const team = [
        { name: "Harshil Biyani", role: "Lead Architect", img: "https://api.dicebear.com/9.x/micah/svg?seed=Harshil&backgroundColor=b6e3f4" },
        { name: "Ansh Dudhe", role: "Full Stack Engineer", img: "https://api.dicebear.com/9.x/micah/svg?seed=Ansh&backgroundColor=c0aede" },
        { name: "Shruti Jahagirdar", role: "Backend Specialist", img: "https://api.dicebear.com/9.x/micah/svg?seed=Shruti&backgroundColor=ffdfbf" },
        { name: "Himanshu Lodha", role: "Frontend UI/UX", img: "https://api.dicebear.com/9.x/micah/svg?seed=Himanshu&backgroundColor=d1d4f9" },
    ];

    return (
        <section className="py-40 bg-[#030303] flex flex-col items-center justify-center overflow-hidden relative">
             
             {/* 1. Animated Background Gradients & Noise */}
             <motion.div 
                animate={{ 
                    scale: [1, 1.2, 1],
                    opacity: [0.2, 0.4, 0.2],
                    rotate: [0, 5, -5, 0]
                }}
                transition={{ 
                    duration: 15, 
                    repeat: Infinity,
                    ease: "easeInOut" 
                }}
                className="absolute -top-1/2 -left-1/2 w-[200%] h-[200%] bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-ubViolet/10 via-[#030303] to-[#030303] blur-3xl pointer-events-none"
             />
             <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 pointer-events-none mix-blend-overlay"></div>

             {/* 2. Enhanced Background Typography */}
             <div className="absolute top-[20%] left-1/2 -translate-x-1/2 -translate-y-1/2 w-full text-center z-0 pointer-events-none select-none">
                 <motion.h2 
                    initial={{ opacity: 0, scale: 0.9 }}
                    whileInView={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 1, ease: "easeOut" }}
                    className="text-[18vw] font-black leading-none text-white/5" 
                    style={{
                        WebkitTextStroke: "2px rgba(255, 255, 255, 0.15)",
                    }}
                 >
                     CREATORS
                 </motion.h2>
             </div>
             
             {/* Cards Grid */}
             <div className="relative z-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 px-6 max-w-7xl w-full">
                 {team.map((member, i) => (
                     <motion.div 
                        initial={{ opacity: 0, y: 50 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        transition={{ delay: i * 0.1, duration: 0.5 }}
                        key={i} 
                        className="group relative bg-white/5 border border-white/10 rounded-[2rem] p-6 backdrop-blur-md hover:-translate-y-2 transition-all duration-300 overflow-hidden hover:border-ubLime/50 hover:shadow-[0_10px_40px_rgba(198,255,51,0.1)]"
                    >
                         
                         {/* Image Container */}
                         <div className="w-full aspect-square rounded-2xl bg-black/40 mb-6 overflow-hidden relative border border-white/5 group-hover:border-ubLime/20 transition-colors">
                            <img 
                                src={member.img} 
                                alt={member.name}
                                className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                            />
                            {/* Overlay Gradient */}
                            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60 group-hover:opacity-40 transition-opacity" />
                            
                            {/* Social/Decor icons */}
                            <div className="absolute top-3 right-3 p-2 bg-black/50 backdrop-blur-md rounded-full text-white/50 group-hover:text-ubLime transition-colors">
                                <Terminal size={14} />
                            </div>
                         </div>

                         {/* Text Content */}
                         <div className="relative">
                             <div className="flex items-center gap-2 mb-2">
                                <div className="h-[1px] w-4 bg-ubLime/50"></div>
                                <div className="text-[10px] font-mono text-ubLime uppercase tracking-wider">0{i+1} // CORE</div>
                             </div>
                             <h3 className="text-2xl font-black text-white mb-1 group-hover:text-ubLime transition-colors">{member.name}</h3>
                             <p className="text-sm text-gray-400 font-medium group-hover:text-gray-300 transition-colors">{member.role}</p>
                         </div>
                         
                         {/* Hover Glow */}
                         <div className="absolute -bottom-20 -right-20 w-40 h-40 bg-ubLime/20 rounded-full blur-[60px] pointer-events-none opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
                     </motion.div>
                 ))}
             </div>
        </section>
    );
};


// ------------------------------------------------------------------
// FOOTER
// ------------------------------------------------------------------
const FooterCTA = () => {
    return (
        <section className="min-h-[60vh] flex flex-col items-center justify-center text-center relative bg-[#080808] border-t border-white/5">
            <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-10" />
            
            <h2 className="text-5xl md:text-8xl font-black mb-8 relative z-10">
                READY TO <span className="text-ubLime">WIRE IN?</span>
            </h2>
            
            <button className="relative z-10 px-12 py-6 bg-white text-black text-xl font-black rounded-full hover:bg-ubLime hover:scale-105 active:scale-95 transition-all flex items-center gap-3">
                INITIALIZE SEQUENCE <ArrowRight size={24} />
            </button>

            <div className="absolute bottom-10 text-gray-600 font-mono text-xs">
                 2026 UNIBUZZ SYSTEMS. ALL RIGHTS RESERVED.
            </div>
        </section>
    );
};

const FeatureBadge = ({ icon: Icon, text }) => (
    <div className="flex items-center gap-2 px-4 py-2 bg-white/5 rounded-lg border border-white/10">
        <Icon size={16} className="text-ubLime" />
        <span className="text-sm font-bold text-gray-300">{text}</span>
    </div>
);

export default AboutPage;
