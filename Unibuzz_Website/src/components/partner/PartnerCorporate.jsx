import React, { useState } from 'react';
import { motion, useMotionValue, useMotionTemplate } from 'framer-motion';
import { TrendingUp, Users, Globe, Zap, CheckCircle, ArrowRight, MousePointer2 } from 'lucide-react';
import Navbar from '../home/Navbar';

const PARTNERSHIP_TIERS = [
  {
    title: 'Seed Partner',
    price: '₹50k - ₹1L',
    borderColor: 'border-fuchsia-500',
    glowColor: 'shadow-fuchsia-500/40',
    textColor: 'text-fuchsia-400',
    buttonStyle: 'bg-fuchsia-500 hover:bg-fuchsia-400 text-black shadow-[0_0_20px_rgba(217,70,239,0.4)]',
    icon: '🌱',
    perks: ['Logo on Website', 'Social Media Shoutout', '1 Event Stall']
  },
  {
    title: 'Orbit Partner',
    price: '₹2L - ₹5L',
    borderColor: 'border-cyan-400',
    glowColor: 'shadow-cyan-400/40',
    textColor: 'text-cyan-400',
    buttonStyle: 'bg-cyan-400 hover:bg-cyan-300 text-black shadow-[0_0_20px_rgba(34,211,238,0.4)]',
    icon: '🪐',
    perks: ['Prime Stall Location', 'Stage Time (5 Mins)', 'Database Access (Partial)', 'Logo on Merch']
  },
  {
    title: 'Galactic Title',
    price: '₹10L+',
    borderColor: 'border-ubLime', 
    glowColor: 'shadow-ubLime/40',
    textColor: 'text-ubLime',
    buttonStyle: 'bg-ubLime hover:bg-ubLime/80 text-black shadow-[0_0_30px_rgba(198,255,51,0.5)]',
    icon: '🚀',
    popular: true,
    perks: ['Title Sponsorship', 'Keynote Session', 'Full Database Access', 'Exclusive Branding Everywhere', 'Custom Activation']
  }
];

const STATS = [
  { label: 'Total Footfall', value: '150,000+', icon: Users },
  { label: 'Campuses', value: '45+', icon: Globe },
  { label: 'Avg Engagement', value: '89%', icon:  MousePointer2 },
  { label: 'Media Impressions', value: '2.5M+', icon: TrendingUp },
];

const PartnerCorporate = () => {
  const mouseX = useMotionValue(0);
  const mouseY = useMotionValue(0);

  // Spotlight Effect Logic
  const handleMouseMove = ({ currentTarget, clientX, clientY }) => {
    const { left, top } = currentTarget.getBoundingClientRect();
    mouseX.set(clientX - left);
    mouseY.set(clientY - top);
  };
  
  const spotlightBg = useMotionTemplate`radial-gradient(600px circle at ${mouseX}px ${mouseY}px, rgba(198, 255, 51, 0.06), transparent 80%)`;
    
  return (
    <div 
      onMouseMove={handleMouseMove}
      className="min-h-screen bg-black text-white font-sans overflow-x-hidden selection:bg-ubViolet selection:text-white relative"
    >
      
      {/* --- DYNAMIC BACKGROUND & TRANSITIONS --- */}
      <div className="fixed inset-0 z-0">
          {/* Spotlight Overlay */}
          <motion.div 
             className="absolute inset-0 z-10 pointer-events-none"
             style={{ background: spotlightBg }}
          />
          
          {/* 1. Base Grid (Perspective effect) */}
          <div className="absolute inset-0 bg-[linear-gradient(to_right,#80808012_1px,transparent_1px),linear-gradient(to_bottom,#80808012_1px,transparent_1px)] bg-[size:24px_24px] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_0%,#000_70%,transparent_100%)]" />
          
          {/* 2. Floating Orbs */}
          <motion.div 
            animate={{ 
                x: [0, 100, 0],
                y: [0, -50, 0],
                scale: [1, 1.2, 1],
                opacity: [0.3, 0.6, 0.3]
            }}
            transition={{ duration: 15, repeat: Infinity, ease: "easeInOut" }}
            className="absolute top-20 left-20 w-[600px] h-[600px] bg-ubViolet/20 rounded-full blur-[100px]" 
          />
          
          <motion.div 
            animate={{ 
                x: [0, -100, 0],
                y: [0, 50, 0],
                scale: [1, 1.4, 1],
                opacity: [0.2, 0.5, 0.2]
            }}
            transition={{ duration: 20, repeat: Infinity, ease: "easeInOut", delay: 2 }}
            className="absolute bottom-20 right-20 w-[500px] h-[500px] bg-ubLime/10 rounded-full blur-[100px]" 
          />

           <motion.div 
            animate={{ 
                x: [0, 50, 0],
                opacity: [0.1, 0.3, 0.1]
            }}
            transition={{ duration: 10, repeat: Infinity, ease: "linear" }}
            className="absolute top-1/3 left-1/2 -translate-x-1/2 w-[800px] h-[200px] bg-blue-500/10 rounded-full blur-[120px]" 
          />

          {/* 3. Noise Texture for localized grit */}
         <div className="absolute inset-0 opacity-20 pointer-events-none bg-[url('https://grainy-gradients.vercel.app/noise.svg')]" />
      </div>

      <div className="relative z-10">
      {/* Navbar is rendered by parent or layout if needed, but included here for completeness if used standalone */}
      {/* <Navbar /> */} 

      {/* --- HERO SECTION: THE HOOK --- */}
      <section className="relative pt-32 pb-20 px-6 max-w-7xl mx-auto flex flex-col items-center text-center">
        
        {/* Background Ambience (Removed static blob in favor of global background) */}
        {/* <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-ubViolet/20 rounded-full blur-[120px] -z-10" /> */}

        <motion.div
           initial={{ opacity: 0, y: 20 }}
           animate={{ opacity: 1, y: 0 }}
           transition={{ duration: 0.6 }}
        >
          <span className="px-4 py-2 rounded-full border border-ubLime/30 bg-ubLime/10 text-ubLime text-xs font-bold uppercase tracking-widest mb-6 inline-block">
            Corporate Access Portal
          </span>
          <h1 className="text-5xl md:text-8xl font-black tracking-tighter mb-6 leading-none">
            DOMINATE THE <br />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubViolet via-fuchsia-500 to-ubLime">
              CAMPUS CULTURE.
            </span>
          </h1>
          <p className="text-zinc-400 text-lg md:text-xl max-w-2xl mx-auto leading-relaxed border-l-2 border-ubLime pl-6 text-left md:text-center md:border-l-0 md:pl-0">
            Stop chasing students with boring ads. Integrate your brand directly into their ecosystem via UniBuzz events, hackathons, and cultural fests.
          </p>
        </motion.div>

        {/* METRICS GRID (The ROI Proof) */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 w-full mt-20">
          {STATS.map((stat, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, scale: 0.9 }}
              whileInView={{ opacity: 1, scale: 1 }}
              transition={{ delay: idx * 0.1 }}
              className="p-6 bg-zinc-900/50 border border-zinc-800 hover:border-ubLime/50 rounded-2xl flex flex-col items-center justify-center gap-2 group hover:-translate-y-1 transition-all"
            >
              <stat.icon className="w-6 h-6 text-zinc-500 group-hover:text-ubLime transition-colors" />
              <h3 className="text-3xl md:text-4xl font-black font-mono text-white">{stat.value}</h3>
              <p className="text-xs text-zinc-500 uppercase tracking-wider">{stat.label}</p>
            </motion.div>
          ))}
        </div>
      </section>

      {/* --- TIERS SECTION: THE MENU --- */}
      <section className="py-20 px-6 max-w-7xl mx-auto">
        <div className="flex flex-col md:flex-row items-end justify-between mb-12">
          <div>
             <h2 className="text-4xl font-black uppercase tracking-tight">Collaboration Matrix</h2>
             <p className="text-zinc-500 mt-2">Choose your level of influence.</p>
          </div>
          <button className="hidden md:flex items-center gap-2 text-ubLime font-bold border-b border-ubLime pb-1 hover:opacity-80">
            Download Media Kit <ArrowRight size={16} />
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {PARTNERSHIP_TIERS.map((tier, idx) => (
            <motion.div
              key={idx}
              whileHover={{ y: -10 }}
              className={`relative p-8 rounded-3xl bg-zinc-900 border ${tier.borderColor} ${tier.glowColor} flex flex-col h-full overflow-hidden shadow-xl transition-all duration-300`}
            >
              {tier.popular && (
                <div className="absolute top-0 right-0 bg-ubLime text-black font-bold px-4 py-1 rounded-bl-2xl text-xs uppercase tracking-widest">
                  Recommended
                </div>
              )}
              
              <div className="text-4xl mb-4">{tier.icon}</div>
              <h3 className={`text-2xl font-bold mb-2 ${tier.textColor}`}>{tier.title}</h3>
              <p className="text-zinc-400 text-sm mb-6">Estimated Investment: <span className="text-white font-mono font-bold text-lg">{tier.price}</span></p>
              
              <ul className="space-y-4 mb-8 flex-1">
                {tier.perks.map((perk, i) => (
                  <li key={i} className="flex items-start gap-3 text-sm text-zinc-300">
                    <CheckCircle className={`w-5 h-5 flex-shrink-0 ${tier.textColor}`} />
                    {perk}
                  </li>
                ))}
              </ul>

              <button className={`w-full py-4 rounded-xl font-bold uppercase tracking-wide transition-all transform hover:scale-[1.02] ${tier.buttonStyle}`}>
                Select Tier
              </button>
            </motion.div>
          ))}
        </div>
      </section>

      {/* --- CONTACT FORM: THE CLOSER --- */}
      <section className="py-20 px-6">
        <div className="max-w-4xl mx-auto bg-zinc-900/40 backdrop-blur-xl rounded-[2rem] p-8 md:p-12 border border-white/10 relative overflow-hidden shadow-2xl">
          
          {/* Decorative Grid */}
          <div className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.03)_1px,transparent_1px)] bg-[size:40px_40px] pointer-events-none" />

          <div className="relative z-10">
            <h2 className="text-3xl font-bold mb-2">Initiate Partnership Protocol</h2>
            <p className="text-zinc-500 mb-8">Fill the details. Our Corporate Relations team will deploy a pitch deck within 24 hours.</p>

            <form className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-1">
                <label className="text-xs font-bold text-zinc-500 uppercase ml-1">Company Name</label>
                <input type="text" placeholder="e.g. Red Bull" className="w-full bg-black border border-zinc-800 rounded-xl p-4 focus:border-ubViolet outline-none transition-colors" />
              </div>
              
              <div className="space-y-1">
                 <label className="text-xs font-bold text-zinc-500 uppercase ml-1">Point of Contact</label>
                 <input type="text" placeholder="Name" className="w-full bg-black border border-zinc-800 rounded-xl p-4 focus:border-ubViolet outline-none transition-colors" />
              </div>

              <div className="space-y-1">
                 <label className="text-xs font-bold text-zinc-500 uppercase ml-1">Corporate Email</label>
                 <input type="email" placeholder="name@company.com" className="w-full bg-black border border-zinc-800 rounded-xl p-4 focus:border-ubViolet outline-none transition-colors" />
              </div>

              <div className="space-y-1">
                 <label className="text-xs font-bold text-zinc-500 uppercase ml-1">Interested Tier</label>
                 <select className="w-full bg-black border border-zinc-800 rounded-xl p-4 focus:border-ubViolet outline-none transition-colors text-zinc-400">
                    <option>Select a tier...</option>
                    <option>Seed Partner</option>
                    <option>Orbit Partner</option>
                    <option>Galactic Title</option>
                 </select>
              </div>

              <div className="col-span-1 md:col-span-2 space-y-1">
                 <label className="text-xs font-bold text-zinc-500 uppercase ml-1">Specific Requirements / Goals</label>
                 <textarea rows="4" placeholder="We want to target CS students for hiring..." className="w-full bg-black border border-zinc-800 rounded-xl p-4 focus:border-ubViolet outline-none transition-colors align-top" />
              </div>

              <div className="col-span-1 md:col-span-2 pt-4">
                <button type="button" className="w-full bg-white text-black font-black text-lg py-4 rounded-xl hover:bg-zinc-200 transition-colors shadow-[0_0_30px_rgba(255,255,255,0.2)]">
                  TRANSMIT REQUEST
                </button>
              </div>
            </form>
          </div>
        </div>
      </section>

      </div> {/* End of relative z-10 wrapper */}
    </div>
  )
}

export default PartnerCorporate;
