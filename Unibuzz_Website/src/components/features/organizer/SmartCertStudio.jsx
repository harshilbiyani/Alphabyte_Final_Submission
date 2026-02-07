import React, { useState, useRef } from 'react';
import { motion } from 'framer-motion';
import Navbar from '../../home/Navbar';

const TEMPLATES = {
  cyber: {
    id: 'cyber',
    name: 'Cyberpunk Glitch',
    bg: 'bg-zinc-900',
    elements: [
      { id: 1, type: 'text', content: 'CERTIFICATE OF COMPLETION', x: 50, y: 40, style: 'text-2xl font-black text-lime-400 tracking-tighter' },
      { id: 2, type: 'text', content: '[ NAME HERE ]', x: 50, y: 100, style: 'text-4xl font-mono text-white font-bold' },
      { id: 3, type: 'text', content: 'Has hacked the mainframe at:', x: 50, y: 160, style: 'text-sm text-zinc-400 font-mono' },
      { id: 4, type: 'text', content: 'HACK-A-THON 2026', x: 50, y: 190, style: 'text-xl text-purple-400 font-bold uppercase' },
      { id: 5, type: 'shape', typeShape: 'line', x: 50, y: 80, style: 'w-64 h-1 bg-lime-400' },
    ]
  },
  elegant: {
    id: 'elegant',
    name: 'Royal Gold',
    bg: 'bg-white',
    elements: [
      { id: 1, type: 'text', content: 'Certificate of Excellence', x: 40, y: 50, style: 'text-3xl font-serif text-amber-600 italic' },
      { id: 2, type: 'text', content: 'Presented to', x: 40, y: 100, style: 'text-sm text-zinc-500 uppercase tracking-widest' },
      { id: 3, type: 'text', content: 'Jane Doe', x: 40, y: 130, style: 'text-5xl font-serif text-zinc-900' },
      { id: 4, type: 'text', content: 'For outstanding performance', x: 40, y: 200, style: 'text-md text-zinc-600' },
      { id: 5, type: 'badge', content: '🏆', x: 300, y: 40, style: 'text-6xl' },
    ]
  },
  minimal: {
    id: 'minimal',
    name: 'Swiss Minimal',
    bg: 'bg-zinc-100',
    elements: [
      { id: 1, type: 'text', content: 'CERTIFIED', x: 30, y: 30, style: 'text-6xl font-black text-zinc-900 tracking-tighter opacity-10' },
      { id: 2, type: 'text', content: 'PARTICIPANT', x: 30, y: 100, style: 'text-xl font-bold text-zinc-800' },
      { id: 3, type: 'text', content: 'ALEX RIDER', x: 30, y: 130, style: 'text-3xl font-light text-zinc-600' },
      { id: 4, type: 'shape', typeShape: 'circle', x: 280, y: 150, style: 'w-32 h-32 rounded-full border-4 border-zinc-900 opacity-20' },
    ]
  },
  retro: {
    id: 'retro',
    name: '8-Bit Arcade',
    bg: 'bg-indigo-900',
    elements: [
      { id: 1, type: 'text', content: 'LEVEL COMPLETE', x: 60, y: 40, style: 'text-2xl font-black text-yellow-400 tracking-widest' },
      { id: 2, type: 'text', content: 'PLAYER 1', x: 60, y: 90, style: 'text-sm font-mono text-pink-400' },
      { id: 3, type: 'text', content: 'START GAME', x: 60, y: 200, style: 'text-lg font-bold bg-white px-4 py-1 text-black' },
      { id: 4, type: 'badge', content: '👾', x: 250, y: 80, style: 'text-8xl animate-bounce' },
    ]
  }
};

const SmartCertStudio = () => {
  const [selectedEvent, setSelectedEvent] = useState('Hack-A-Thon 2026');
  const [canvasElements, setCanvasElements] = useState(TEMPLATES.cyber.elements);
  const [activeBg, setActiveBg] = useState(TEMPLATES.cyber.bg);
  const [selectedId, setSelectedId] = useState(null);

  const loadTemplate = (key) => {
    setCanvasElements(TEMPLATES[key].elements);
    setActiveBg(TEMPLATES[key].bg);
    setSelectedId(null);
  };

  const addText = () => {
    const newId = Date.now();
    setCanvasElements([...canvasElements, {
      id: newId,
      type: 'text',
      content: 'New Text Layer',
      x: 100,
      y: 100,
      style: 'text-xl font-bold text-zinc-500'
    }]);
  };

  const updateElementText = (id, newText) => {
    setCanvasElements(canvasElements.map(el => 
      el.id === id ? { ...el, content: newText } : el
    ));
  };

  return (
    <div className="min-h-screen bg-black text-white font-sans selection:bg-lime-400 selection:text-black">
      <Navbar />
      
      <div className="flex h-[calc(100vh-80px)] pt-20 overflow-hidden">
        
        {/* SIDEBAR: TOOLS */}
        <div className="w-80 border-r border-zinc-800 bg-zinc-900/50 backdrop-blur-md p-6 flex flex-col gap-8 z-10 overflow-y-auto">
          
          {/* Event Selector */}
          <div>
            <label className="text-xs font-bold text-lime-400 uppercase mb-2 block tracking-widest">Select Event Context</label>
            <select 
              value={selectedEvent} 
              onChange={(e) => setSelectedEvent(e.target.value)}
              className="w-full bg-black border border-zinc-700 rounded-lg p-3 text-sm focus:border-lime-400 outline-none transition-colors"
            >
              <option>Technova 2026</option>
              <option>RoboWars Championship</option>
              <option>Cultural Fest 'Nritya'</option>
              <option>Formula Student Race</option>
              <option>Hack-A-Thon 2026</option>
            </select>
          </div>

          {/* Templates Grid */}
          <div>
            <label className="text-xs font-bold text-zinc-500 uppercase mb-3 block tracking-widest">Load Template</label>
            <div className="grid grid-cols-2 gap-3">
              {Object.keys(TEMPLATES).map((key) => (
                <button 
                  key={key}
                  onClick={() => loadTemplate(key)}
                  className="h-20 rounded-lg border border-zinc-700 bg-zinc-800 hover:border-lime-400 hover:bg-zinc-700 transition-all flex items-center justify-center text-xs font-bold uppercase text-zinc-400 hover:text-white"
                >
                  {TEMPLATES[key].name}
                </button>
              ))}
            </div>
          </div>

          {/* Toolbox */}
          <div>
            <label className="text-xs font-bold text-zinc-500 uppercase mb-3 block tracking-widest">Toolbox</label>
            <div className="flex flex-col gap-2">
              <button onClick={addText} className="flex items-center gap-3 p-3 rounded bg-zinc-800 hover:bg-zinc-700 border border-zinc-700 transition-all text-sm font-medium">
                <span className="text-xl">T</span> Add Text Layer
              </button>
              <button className="flex items-center gap-3 p-3 rounded bg-zinc-800 hover:bg-zinc-700 border border-zinc-700 transition-all text-sm font-medium opacity-50 cursor-not-allowed">
                <span className="text-xl">O</span> Add Shape (Premium)
              </button>
            </div>
          </div>

          {/* Action */}
          <div className="mt-auto">
            <button className="w-full py-4 bg-lime-400 text-black font-black uppercase text-lg hover:bg-lime-500 transition-colors rounded-xl shadow-[0_0_20px_rgba(163,230,53,0.3)]">
              Export Design
            </button>
            <p className="text-center text-xs text-zinc-600 mt-2">Exports as High-Res PNG</p>
          </div>

        </div>

        {/* WORKSPACE: CANVAS */}
        <div className="flex-1 bg-zinc-950 relative overflow-hidden flex items-center justify-center p-10 bg-[url('https://grainy-gradients.vercel.app/noise.svg')]">
          
          {/* The Canvas Area */}
          <div 
            className={`relative w-[800px] h-[500px] shadow-2xl overflow-hidden transition-colors duration-500 ${activeBg}`}
            style={{ boxShadow: '0 0 50px rgba(0,0,0,0.5)' }}
          >
            {/* Grid Overlay for alignment (Visual only) */}
            <div className="absolute inset-0 pointer-events-none opacity-10 bg-[linear-gradient(to_right,#80808012_1px,transparent_1px),linear-gradient(to_bottom,#80808012_1px,transparent_1px)] bg-[size:24px_24px]"></div>

            {/* Render Elements */}
            {canvasElements.map((el) => (
              <motion.div
                key={el.id}
                drag
                dragMomentum={false}
                onClick={() => setSelectedId(el.id)}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                whileHover={{ scale: 1.02, cursor: 'move' }}
                className={`absolute ${selectedId === el.id ? 'ring-2 ring-lime-400 ring-offset-2 ring-offset-black' : ''}`}
                style={{ 
                  left: el.x, 
                  top: el.y, 
                }}
              >
                {el.type === 'text' && (
                  <input 
                    value={el.content}
                    onChange={(e) => updateElementText(el.id, e.target.value)}
                    className={`bg-transparent border-none outline-none w-auto min-w-[200px] ${el.style}`}
                    style={{ background: 'transparent' }}
                  />
                )}
                {el.type === 'badge' && (
                   <div className={`${el.style}`}>{el.content}</div>
                )}
                 {el.type === 'shape' && (
                   <div className={`${el.style}`}></div>
                )}
              </motion.div>
            ))}
          </div>

          {/* Floating Instructions */}
          <div className="absolute bottom-8 right-8 bg-black/80 backdrop-blur border border-zinc-800 p-4 rounded-lg text-xs text-zinc-400">
            <p>💡 Drag elements to rearrange.</p>
            <p>💡 Click text to edit content.</p>
          </div>

        </div>
      </div>
    </div>
  );
};

export default SmartCertStudio;