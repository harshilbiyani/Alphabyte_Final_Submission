import React from 'react';
import { motion } from 'framer-motion';
import { Activity, Wifi, Zap, MessageCircle } from 'lucide-react';

const PulseNetworkSection = () => {
    return (
        <section className="relative py-32 bg-ubBlack overflow-hidden border-t border-white/5">
            {/* Ambient Backlight */}
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[80vw] h-[80vw] bg-ubViolet/5 rounded-full blur-[150px] pointer-events-none" />

            <div className="max-w-7xl mx-auto px-6 relative z-10">
                <div className="text-center mb-20">
                    <motion.div 
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        className="inline-block"
                    >
                         <h2 className="text-5xl md:text-8xl font-black text-transparent bg-clip-text bg-gradient-to-r from-white via-gray-400 to-gray-800 tracking-tighter uppercase mb-4">
                            Kill The <span className="text-ubLime italic">Noise.</span>
                        </h2>
                        <p className="text-gray-400 text-xl md:text-2xl max-w-2xl mx-auto">
                            Stop scrolling past PDFs. Start living the campus timeline.
                        </p>
                    </motion.div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {/* Card 1: The Problem (FOMO) */}
                    <motion.div 
                        whileHover={{ scale: 1.02, rotate: -2 }}
                        className="p-8 rounded-3xl bg-white/5 border border-white/10 backdrop-blur-sm relative group overflow-hidden"
                    >
                        <div className="absolute inset-0 bg-gradient-to-br from-red-500/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                        <Activity className="size-12 text-red-500 mb-6 animate-pulse" />
                        <h3 className="text-3xl font-bold text-white mb-4">No More FOMO</h3>
                        <p className="text-gray-400">
                            "Did that happen yesterday?" — never say that again. Real-time alerts for the vibes that matter.
                        </p>
                        <div className="mt-8 flex gap-2">
                             {[1,2,3].map(i => (
                                 <div key={i} className="h-2 flex-1 bg-white/10 rounded-full overflow-hidden">
                                     <div className="h-full bg-red-500 w-[60%] animate-pulse" style={{ animationDelay: `${i*0.2}s`}} />
                                 </div>
                             ))}
                        </div>
                    </motion.div>

                    {/* Card 2: The Solution (Sync) */}
                    <motion.div 
                        whileHover={{ scale: 1.05, y: -10 }}
                        className="p-8 rounded-3xl bg-ubLime text-black border border-ubLime relative overflow-hidden shadow-[0_0_50px_rgba(198,255,51,0.2)] md:-mt-12"
                    >
                         <div className="absolute top-0 right-0 p-4 opacity-50">
                             <Wifi className="size-24 rotate-45" />
                         </div>
                        <Zap className="size-12 text-black mb-6 fill-current" />
                        <h3 className="text-3xl font-bold mb-4">Instant Sync</h3>
                        <p className="font-medium opacity-80">
                            One tap RSVP. Auto-calendar sync. Your social life, automated.
                        </p>
                        <div className="mt-8 bg-black/10 p-4 rounded-xl font-mono text-xs">
                            <div className="flex justify-between mb-2">
                                <span>STATUS</span>
                                <span className="font-bold">CONNECTED</span>
                            </div>
                             <div className="w-full bg-black/20 h-1 rounded-full">
                                 <div className="bg-black h-1 rounded-full w-full animate-[shimmer_2s_infinite]" />
                             </div>
                        </div>
                    </motion.div>

                    {/* Card 3: The Community (Tribe) */}
                    <motion.div 
                        whileHover={{ scale: 1.02, rotate: 2 }}
                        className="p-8 rounded-3xl bg-white/5 border border-white/10 backdrop-blur-sm relative group overflow-hidden"
                    >
                        <div className="absolute inset-0 bg-gradient-to-bl from-ubViolet/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                        <MessageCircle className="size-12 text-ubViolet mb-6" />
                        <h3 className="text-3xl font-bold text-white mb-4">Find Your Tribe</h3>
                        <p className="text-gray-400">
                            Artists, Hackers, Gamers. Don't just attend events. Build communities.
                        </p>
                        
                        {/* Avatar Pile simulation */}
                        <div className="mt-8 flex -space-x-4">
                            {[1,2,3,4].map(i => (
                                <div key={i} className={`size-10 rounded-full border-2 border-ubBlack bg-gray-800 flex items-center justify-center text-xs overflow-hidden`}>
                                    <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${i*123}`} alt="avatar" />
                                </div>
                            ))}
                            <div className="size-10 rounded-full border-2 border-ubBlack bg-ubViolet flex items-center justify-center text-xs font-bold">
                                +99
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    );
};

export default PulseNetworkSection;
