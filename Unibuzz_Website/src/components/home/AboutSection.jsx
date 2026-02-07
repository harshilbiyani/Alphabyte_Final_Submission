import React from 'react';
import { motion } from 'framer-motion';
import { ArrowUpRight, Users, Zap } from 'lucide-react';

const AboutSection = () => {
    return (
        <section id="about" className="relative py-20 bg-ubBlack text-white overflow-hidden">
            {/* Background Noise/Grid */}
            <div className="absolute inset-0 opacity-20" 
                style={{ backgroundImage: 'radial-gradient(#4a4a4a 1px, transparent 1px)', backgroundSize: '30px 30px' }} 
            />

            <div className="max-w-7xl mx-auto px-4 relative z-10">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
                    
                    {/* Left: Text Content */}
                    <motion.div 
                        initial={{ opacity: 0, x: -50 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                        className="space-y-6"
                    >
                        <div className="inline-block bg-ubViolet/20 text-ubViolet px-4 py-1 rounded-full text-xs font-bold uppercase tracking-wider border border-ubViolet/30">
                            About The Platform
                        </div>
                        <h2 className="text-4xl md:text-6xl font-black leading-tight">
                            The New Age of <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">Campus Buzz.</span>
                        </h2>
                        <p className="text-gray-400 text-lg leading-relaxed">
                            UniBuzz isn't just an event board. It's the digital heartbeat of your campus. 
                            We connect students, creators, and rebels to build moments that actually matter.
                            No more boring flyers. No more missed connections.
                        </p>

                        <div className="grid grid-cols-2 gap-4 mt-8">
                            <div className="p-4 rounded-xl bg-white/5 border border-white/10 hover:border-ubLime transition-colors group">
                                <Users className="text-ubLime mb-3 group-hover:scale-110 transition-transform" />
                                <h4 className="font-bold text-xl">10K+</h4>
                                <p className="text-gray-500 text-sm">Active Students</p>
                            </div>
                            <div className="p-4 rounded-xl bg-white/5 border border-white/10 hover:border-ubViolet transition-colors group">
                                <Zap className="text-ubViolet mb-3 group-hover:scale-110 transition-transform" />
                                <h4 className="font-bold text-xl">500+</h4>
                                <p className="text-gray-500 text-sm">Live Events</p>
                            </div>
                        </div>

                        <button className="mt-8 flex items-center gap-2 px-8 py-4 bg-ubLime text-black font-bold rounded-lg hover:bg-white transition-all transform hover:-translate-y-1 shadow-[4px_4px_0px_0px_rgba(255,255,255,0.2)]">
                            Join the Hive <ArrowUpRight size={20} />
                        </button>
                    </motion.div>

                    {/* Right: Abstract Bento Grid / Visuals */}
                    <motion.div 
                        initial={{ opacity: 0, scale: 0.9 }}
                        whileInView={{ opacity: 1, scale: 1 }}
                        viewport={{ once: true }}
                        className="relative h-[500px] w-full"
                    >
                        {/* Interactive-looking cards */}
                        <div className="absolute top-10 right-10 w-64 h-80 bg-gradient-to-br from-ubViolet to-indigo-900 rounded-2xl rotate-6 border border-white/10 z-10 flex items-center justify-center">
                            <span className="text-6xl">🎨</span>
                        </div>
                        <div className="absolute top-20 right-40 w-64 h-80 bg-ubBlack border border-white/20 rounded-2xl -rotate-6 z-20 overflow-hidden shadow-2xl">
                             <div className="p-4 border-b border-white/10 flex justify-between">
                                <div className="flex gap-2">
                                    <div className="w-3 h-3 rounded-full bg-red-500"></div>
                                    <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
                                    <div className="w-3 h-3 rounded-full bg-green-500"></div>
                                </div>
                             </div>
                             <div className="p-6 space-y-4">
                                <div className="h-2 w-3/4 bg-white/20 rounded"></div>
                                <div className="h-2 w-1/2 bg-white/20 rounded"></div>
                                <div className="h-2 w-full bg-white/10 rounded"></div>
                                <div className="mt-8 p-4 bg-ubLime/10 rounded-lg border border-ubLime/20">
                                    <p className="text-ubLime text-xs font-mono">System.init_buzz_protocol(true);</p>
                                </div>
                             </div>
                        </div>
                        
                        {/* Floating elements */}
                        <div className="absolute bottom-20 left-10 p-4 bg-white text-black font-bold rounded-lg shadow-xl -rotate-12 z-30">
                            #NO_FOMO
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    );
};

export default AboutSection;
