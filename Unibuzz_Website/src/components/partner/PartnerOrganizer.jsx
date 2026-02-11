import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Check, Star, Zap, Crown, TrendingUp, Shield, Rocket } from 'lucide-react';

const PartnerOrganizer = () => {
  const [activePlan, setActivePlan] = useState(1);

  const plans = [
    {
      id: 0,
      name: "Starter",
      events: "1 Event",
      price: "₹499",
      period: "/event",
      color: "border-gray-500",
      bgFrom: "from-gray-900",
      features: ["Basic Dashboard", "Standard Support", "Manual Reports"]
    },
    {
      id: 1,
      name: "Club",
      events: "5 Events",
      price: "₹1,999",
      period: "/sem",
      tag: "POPULAR",
      color: "border-ubLime",
      bgFrom: "from-ubLime/20",
      features: ["Finance Vault Access", "On-Spot Registration", "Priority Support", "Email Blasting"]
    },
    {
      id: 2,
      name: "Pro",
      events: "10 Events",
      price: "₹3,499",
      period: "/year",
      color: "border-ubViolet",
      bgFrom: "from-ubViolet/20",
      features: ["AI Report Generator", "Organizer Certificate", "Sponsor Connect", "Full Analytics"]
    },
    {
      id: 3,
      name: "Dominator",
      events: "Unlimited",
      price: "Custom",
      period: "",
      color: "border-amber-400",
      bgFrom: "from-amber-500/20",
      features: ["Dedicated Manager", "White-label Solution", "API Access", "24/7 Hotline"]
    }
  ];

  return (
    <div className="min-h-screen bg-black text-white pt-24 px-4 pb-20 overflow-hidden relative font-sans">
      <div className="absolute top-0 left-0 w-full h-[500px] bg-gradient-to-b from-ubViolet/10 to-black pointer-events-none" />
      
      {/* Header */}
      <div className="max-w-4xl mx-auto text-center mb-16 relative z-10">
        <motion.div
           initial={{ opacity: 0, y: 20 }}
           animate={{ opacity: 1, y: 0 }}
           className="inline-block px-4 py-1 rounded-full bg-ubLime/10 border border-ubLime/30 text-ubLime text-xs font-bold tracking-widest uppercase mb-4"
        >
          For Organizers
        </motion.div>
        <h1 className="text-5xl md:text-7xl font-black mb-6 tracking-tight">
          Scale Your <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-emerald-400">Impact</span>
        </h1>
        <p className="text-xl text-gray-400 max-w-2xl mx-auto">
          Unlock the full "Organizer Suite." From AI-generated reports to financial auditing. Choose the fuel specifically for your club's rocket.
        </p>
      </div>

      {/* Pricing Cards */}
      <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-24 relative z-10">
        {plans.map((plan, index) => (
          <motion.div
            key={plan.id}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            onMouseEnter={() => setActivePlan(index)}
            className={`cursor-pointer group relative p-1 rounded-3xl bg-gradient-to-b ${index === activePlan ? 'from-white/40 to-white/5 scale-105 z-20 shadow-[0_0_40px_rgba(125,57,235,0.3)]' : 'from-white/10 to-white/0'} transition-all duration-300`}
          >
            <div className={`h-full bg-[#0A0A0A] rounded-[22px] p-6 flex flex-col border ${plan.color} relative overflow-hidden`}>
              {/* Background Glow */}
              <div className={`absolute -top-20 -right-20 w-40 h-40 bg-gradient-to-br ${plan.bgFrom} to-transparent blur-3xl opacity-50 group-hover:opacity-100 transition-opacity`} />

              {plan.tag && (
                <div className="absolute top-0 right-0 bg-ubLime text-black text-[10px] font-black px-3 py-1 rounded-bl-xl shadow-lg">
                  {plan.tag}
                </div>
              )}

              <h3 className="text-xl font-bold text-gray-300 mb-1">{plan.name}</h3>
              <div className="text-sm font-mono text-gray-500 mb-6 flex items-center gap-2">
                <Rocket size={14} /> {plan.events}
              </div>

              <div className="text-4xl font-black text-white mb-8">
                {plan.price}<span className="text-sm font-medium text-gray-600">{plan.period}</span>
              </div>

              <div className="space-y-4 mb-8 flex-1">
                {plan.features.map((feat, i) => (
                  <div key={i} className="flex items-center gap-3 text-sm text-gray-400">
                    <Check size={16} className={`text-${plan.name === 'Club' ? 'ubLime' : 'ubViolet'} flex-shrink-0`} />
                    {feat}
                  </div>
                ))}
              </div>

              <button className={`w-full py-4 rounded-xl font-bold text-sm uppercase tracking-wide transition-all ${
                index === activePlan 
                ? 'bg-ubLime text-black hover:bg-white shadow-[0_0_20px_rgba(204,255,0,0.3)]' 
                : 'bg-white/5 text-white hover:bg-white/10'
              }`}>
                Select Plan
              </button>
            </div>
          </motion.div>
        ))}
      </div>

      {/* Feature Grid */}
      <div className="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 mb-20 relative z-10">
        {[
          { icon: Zap, title: "Instant Setup", desc: "Go live in seconds. Our wizard handles the boring stuff." },
          { icon: TrendingUp, title: "Live Analytics", desc: "Track every click, registration, and dollar in real-time." },
          { icon: Shield, title: "Fraud Proof", desc: "Secure ticketing and attendance systems built-in." }
        ].map((item, i) => (
          <motion.div 
            key={i} 
            whileHover={{ y: -5 }}
            className="bg-white/5 border border-white/5 p-8 rounded-3xl backdrop-blur-sm hover:bg-white/10 transition-colors"
          >
            <div className="w-12 h-12 rounded-xl bg-ubViolet/20 flex items-center justify-center mb-6">
              <item.icon className="text-ubViolet" />
            </div>
            <h4 className="text-xl font-bold text-white mb-2">{item.title}</h4>
            <p className="text-gray-400">{item.desc}</p>
          </motion.div>
        ))}
      </div>

      {/* CTA / Form Launcher */}
      <div className="max-w-3xl mx-auto text-center relative z-10">
        <motion.button 
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="px-12 py-5 bg-white text-black text-lg font-black rounded-full hover:bg-gray-100 transition-colors shadow-[0_0_30px_rgba(255,255,255,0.3)]"
        >
          Start Your Free Trial
        </motion.button>
        <p className="text-gray-500 mt-4 text-sm">No credit card required for Starter plan.</p>
      </div>
    </div>
  );
}

export default PartnerOrganizer;
