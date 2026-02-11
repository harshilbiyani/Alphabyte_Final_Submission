import React from 'react';
import { motion } from 'framer-motion';
import { Sparkles, Trophy, Gift, ArrowRight } from 'lucide-react';

const PartnerStudent = () => {
    
  return (
    <div className="min-h-screen bg-black text-white pt-24 px-4 pb-20 relative overflow-hidden font-sans">
        {/* Wild Background */}
        <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-ubLime/10 rounded-full blur-[150px] pointer-events-none" />
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-ubViolet/10 rounded-full blur-[150px] pointer-events-none" />

        <div className="max-w-6xl mx-auto relative z-10">
            {/* Hero */}
            <div className="flex flex-col md:flex-row items-center gap-12 mb-24">
                <div className="flex-1">
                    <motion.div 
                        initial={{ opacity: 0, rotate: -5 }} 
                        animate={{ opacity: 1, rotate: 0 }}
                        className="inline-block bg-ubLime text-black font-black text-sm px-4 py-2 rounded-lg -rotate-2 mb-6 shadow-[4px_4px_0px_rgba(255,255,255,0.2)]"
                    >
                        CAMPUS AMBASSADOR PROGRAM
                    </motion.div>
                    <h1 className="text-6xl md:text-8xl font-black leading-[0.9] mb-8">
                        BE THE <br />
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-emerald-300">MAIN</span> <br />
                        CHARACTER.
                    </h1>
                    <p className="text-xl text-gray-400 mb-8 max-w-lg">
                        Lead the revolution on your campus. Get exclusive merch, backdoor access to events, and redeemable points for real cash/vouchers.
                    </p>
                    <motion.button 
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                        className="group relative px-8 py-4 bg-white text-black font-black text-xl rounded-2xl overflow-hidden"
                    >
                        <div className="absolute inset-0 bg-ubViolet translate-y-full group-hover:translate-y-0 transition-transform duration-300" />
                        <span className="relative z-10 group-hover:text-white transition-colors flex items-center gap-2">
                            APPLY NOW <ArrowRight />
                        </span>
                    </motion.button>
                </div>

                <div className="flex-1 relative hidden md:block">
                    <motion.div 
                        animate={{ y: [0, -20, 0] }}
                        transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                        className="relative w-full aspect-square bg-gradient-to-br from-ubViolet to-indigo-900 rounded-[3rem] p-8 border-4 border-white/10 rotate-3 hover:rotate-0 transition-all duration-500 shadow-2xl"
                    >
                        <div className="absolute inset-x-8 top-8 bottom-24 bg-black/20 rounded-2xl backdrop-blur-sm border border-white/10 p-6 flex flex-col justify-between">
                            <div className="flex justify-between items-start">
                                <div className="w-16 h-16 bg-white/10 rounded-full animate-pulse" />
                                <div className="text-4xl">🔥</div>
                            </div>
                            <div>
                                <div className="h-4 w-3/4 bg-white/20 rounded mb-3" />
                                <div className="h-4 w-1/2 bg-white/20 rounded" />
                            </div>
                        </div>
                        <div className="absolute bottom-8 left-8 right-8 h-12 bg-ubLime rounded-xl flex items-center justify-center font-black text-black tracking-wider">
                             AMBASSADOR ID CARD
                        </div>
                    </motion.div>
                </div>
            </div>

            {/* Benefits Grid */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-24">
                {[
                    { icon: Gift, title: "The Loot", desc: "Access to exclusive hoodies, stickers, and tech gadgets." },
                    { icon: Trophy, title: "The Fame", desc: "Get featured on our socials and verified badge on app." },
                    { icon: Sparkles, title: "The XP", desc: "Certificates and LinkedIn recommendations for your CV." }
                ].map((item, i) => (
                    <motion.div 
                        key={i} 
                        whileHover={{ y: -5 }}
                        className="bg-[#121212] border border-white/5 p-8 rounded-3xl hover:bg-white/5 transition-colors group cursor-default"
                    >
                        <div className="w-14 h-14 bg-ubLime/20 rounded-full flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <item.icon className="text-ubLime" size={28} />
                        </div>
                        <h3 className="text-2xl font-bold text-white mb-3">{item.title}</h3>
                        <p className="text-gray-400 font-medium">{item.desc}</p>
                    </motion.div>
                ))}
            </div>
            
            {/* Simple Form Section */}
            <div className="max-w-2xl mx-auto bg-ubViolet/10 border border-ubViolet/30 p-10 rounded-3xl text-center">
                 <h2 className="text-3xl font-black mb-4">Join the Squad</h2>
                 <p className="text-gray-400 mb-8">Upload a 30s video telling us why you are the best fit.</p>
                 <div className="h-32 border-2 border-dashed border-white/20 rounded-xl flex items-center justify-center mb-6 hover:border-ubLime transition-colors cursor-pointer bg-black/20 group">
                    <span className="text-gray-500 font-mono text-sm group-hover:text-ubLime transition-colors">Drop video or resume here</span>
                 </div>
                 <button className="w-full py-4 bg-ubLime text-black font-bold rounded-xl hover:opacity-90 transition-opacity">SUBMIT APPLICATION</button>
            </div>

        </div>
    </div>
  )
}

export default PartnerStudent;
