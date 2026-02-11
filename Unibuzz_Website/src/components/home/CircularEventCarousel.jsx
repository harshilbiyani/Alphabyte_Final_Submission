import React, { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";

const CARDS = [
  { id: 1, title: "Hackathon", img: "https://images.unsplash.com/photo-1504384308090-c54be3855833?q=80&w=600&auto=format&fit=crop" }, // Coding
  { id: 2, title: "Music Fest", img: "https://images.unsplash.com/photo-1459749411177-0473ef716175?q=80&w=600&auto=format&fit=crop" }, // Concert
  { id: 3, title: "Robotics", img: "https://images.unsplash.com/photo-1561557944-6e7860d1a7eb?q=80&w=600&auto=format&fit=crop" }, // Robot
  { id: 4, title: "E-Sports", img: "https://images.unsplash.com/photo-1593305841991-05c29736ce37?q=80&w=600&auto=format&fit=crop" }, // Gaming
  { id: 5, title: "Workshop", img: "https://images.unsplash.com/photo-1531403009284-440f080d1e12?q=80&w=600&auto=format&fit=crop" }, // Seminar
  { id: 6, title: "Race Day", img: "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=600&auto=format&fit=crop" }, // Car
  { id: 7, title: "Art Expo", img: "https://images.unsplash.com/photo-1560421683-6856ea585c78?q=80&w=600&auto=format&fit=crop" }, // Art
  { id: 8, title: "Cultural", img: "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=600&auto=format&fit=crop" }, // Party
];

const CircularEventCarousel = () => {
    const [rotation, setRotation] = useState(0);
    const cardCount = CARDS.length;
    const radius = 400; // Radius of the cylinder
    const cardWidth = 220; // Width of cards
    const cardHeight = 320; // Height of cards

    // Auto-rotate
    useEffect(() => {
        const interval = setInterval(() => {
            setRotation(prev => prev - 0.5); 
        }, 20);
        return () => clearInterval(interval);
    }, []);

    return (
        <div className="relative h-[800px] w-full bg-ubBlack flex flex-col items-center justify-center overflow-hidden perspective py-20">
            
            <div className="absolute top-10 text-center z-10 w-full px-4">
                <span className="text-ubLime font-mono text-sm tracking-widest uppercase">/// Immersive View</span>
                <h2 className="text-4xl md:text-5xl font-bold text-white mt-2">Explore The Meta-Events</h2>
            </div>

            {/* 3D Scene Container */}
            <div 
                className="relative w-full h-[600px] mt-20" 
                style={{ 
                    perspective: "1200px", 
                    perspectiveOrigin: "50% 50%" 
                }}
            >
                {/* The Rotating Cylinder */}
                <motion.div
                    className="absolute top-1/2 left-1/2 w-0 h-0"
                    style={{
                         transformStyle: "preserve-3d",
                         transform: `rotateY(${rotation}deg)`
                    }}
                >
                    {CARDS.map((card, i) => {
                        const angle = (360 / cardCount) * i;
                        // Position cards in a circle
                        // We translate Z to push them out to radius
                        // We rotate Y to face 'outwards' from center
                        return (
                            <div
                                key={card.id}
                                className="absolute top-0 left-0 bg-gray-800 rounded-xl border border-white/20 overflow-hidden shadow-[0_0_30px_rgba(125,57,235,0.3)] transition-all hover:border-ubLime hover:shadow-ubLime/50 cursor-pointer group"
                                style={{
                                    width: `${cardWidth}px`, // 220px
                                    height: `${cardHeight}px`, // 320px
                                    marginLeft: `-${cardWidth / 2}px`, // Center horizontally
                                    marginTop: `-${cardHeight / 2}px`, // Center vertically? No, we want them hanging
                                    transform: `rotateY(${angle}deg) translateZ(${radius}px)`,
                                    backfaceVisibility: "visible"
                                }}
                            >
                                <div className="absolute inset-0 bg-black/10 group-hover:bg-transparent transition-colors z-10" />
                                <img src={card.img} alt={card.title} className="w-full h-full object-cover" />
                                
                                {/* Info on hover - appears floating in front */}
                                <div className="absolute bottom-0 left-0 right-0 p-4 bg-gradient-to-t from-black to-transparent opacity-0 group-hover:opacity-100 transition-opacity z-20">
                                    <h3 className="text-white font-bold text-lg">{card.title}</h3>
                                    <p className="text-ubLime text-xs">Tap to view details</p>
                                </div>
                            </div>
                        );
                    })}
                </motion.div>
                
                {/* Floor Reflection Gradient (Optional for depth) */}
                <div className="absolute -bottom-60 left-1/2 -translate-x-1/2 w-[800px] h-[800px] bg-ubViolet/10 rounded-full blur-[100px] pointer-events-none transform rotateX(90deg)" />
            </div>

            <p className="text-gray-500 text-sm mt-12 animate-pulse">Drag to Rotate (Coming Soon)</p>
        </div>
    );
};

export default CircularEventCarousel;
