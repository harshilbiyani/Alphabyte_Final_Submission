import React from 'react';
import { motion } from 'framer-motion';
import { 
  User, Mail, MapPin, Calendar, Award, TrendingUp, Users, DollarSign, 
  Target, BarChart2, Star, Shield, ExternalLink, ArrowRight, Zap,
  Briefcase, Megaphone, Globe
} from 'lucide-react';
import Navbar from '../home/Navbar';
import { useUser } from '../../context/UserContext';

const VibeCheckTitle = ({ type }) => {
  const gradientClass = type === 'sponsor' 
    ? 'from-cyan-400 via-white to-cyan-400'
    : type === 'corporate'
    ? 'from-ubViolet via-white to-ubViolet'
    : 'from-ubLime via-white to-ubLime';

  return (
    <div className="relative group cursor-pointer inline-flex items-center gap-2">
      {/* Animated Vibe-Check replacing the badge */}
      <div className="relative">
        <motion.span 
          className={`font-mono italic font-black text-2xl md:text-3xl tracking-tighter text-transparent bg-clip-text bg-gradient-to-r ${gradientClass} filter drop-shadow-[0_0_8px_rgba(255,255,255,0.3)]`}
          animate={{ 
            textShadow: ["0 0 10px rgba(255,255,255,0.2)", "0 0 20px rgba(255,255,255,0.6)", "0 0 10px rgba(255,255,255,0.2)"],
            opacity: [0.8, 1, 0.8]
          }}
          transition={{ duration: 2, repeat: Infinity }}
        >
          Vibe-Check
        </motion.span>
        
        {/* Absolute positioning for glitch effect layer */}
        <motion.span 
          className={`absolute top-0 left-0 font-mono italic font-black text-2xl md:text-3xl tracking-tighter text-white opacity-30 mix-blend-overlay`}
          animate={{ x: [-2, 2, -1, 1, 0] }}
          transition={{ repeat: Infinity, duration: 2.5, repeatDelay: 1 }}
        >
          Vibe-Check
        </motion.span>
      </div>
    </div>
  );
};

const ProfilePage = () => {
  const { currentUser } = useUser();

  // Mock data for profiles - in a real app these would come from an API or UserContext
  const organizerData = {
    eventsHeld: 24,
    totalSponsors: 15,
    roi: "185%",
    registrations: "4.2k",
    ranking: "3rd",
    institute: "Alpha Technical Institute",
    metrics: [
      { label: "Completion Rate", value: "94%", color: "text-ubLime" },
      { label: "Avg Rating", value: "4.8/5", color: "text-yellow-400" },
      { label: "Reach", value: "12k+", color: "text-ubViolet" }
    ],
    recentEvents: [
      { id: 1, name: "Tech-X 2025", date: "Jan 15, 2026", status: "Completed", attendees: 450 },
      { id: 2, name: "Design Sprint", date: "Dec 10, 2025", status: "Completed", attendees: 120 },
      { id: 3, name: "Code Jam", date: "Nov 22, 2025", status: "Completed", attendees: 300 }
    ]
  };

  const sponsorData = {
    totalSpent: "$12,400",
    eventsSponsored: 8,
    reachImpressions: "45k",
    topEvent: "HackTheVerse 2025",
    brandHealth: "92%",
    metrics: [
      { label: "Leads Generated", value: "850", color: "text-cyan-400" },
      { label: "Conversion Rate", value: "12.5%", color: "text-pink-400" },
      { label: "Brand Recall", value: "High", color: "text-ubLime" }
    ],
    activeSponsorships: [
      { id: 1, event: "Startup Weekend", budget: "$1,500", status: "Active" },
      { id: 2, event: "Campus Recruiters", budget: "$2,000", status: "Planning" }
    ]
  };

  const corporateData = {
    hires: 45,
    internships: 120,
    hackathonsHosted: 5,
    talentQuality: "A+",
    metrics: [
      { label: "Applied Candidates", value: "1.2k", color: "text-ubViolet" },
      { label: "Selection Ratio", value: "1:25", color: "text-ubLime" },
      { label: "Retention Rate", value: "88%", color: "text-ubViolet" }
    ],
    engagements: [
      { id: 1, type: "Hackathon", name: "Innovate2.0", candidates: 500 },
      { id: 2, type: "Workshop", name: "AI Future", candidates: 200 }
    ]
  };

  const getProfileImage = () => {
    const seed = currentUser?.type === 'corporate' ? 'Business' : currentUser?.type === 'sponsor' ? 'Brand' : 'Felix';
    return `https://api.dicebear.com/7.x/avataaars/svg?seed=${seed}`;
  };

  const renderOrganizerProfile = () => (
    <div className="space-y-8">
      {/* Stats Grid */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Events Held", value: organizerData.eventsHeld, icon: Calendar, color: "bg-ubLime/20 text-ubLime" },
          { label: "Total Sponsors", value: organizerData.totalSponsors, icon: Users, color: "bg-ubViolet/20 text-ubViolet" },
          { label: "Avg. ROI", value: organizerData.roi, icon: TrendingUp, color: "bg-cyan-400/20 text-cyan-400" },
          { label: "Registrations", value: organizerData.registrations, icon: User, color: "bg-pink-400/20 text-pink-400" }
        ].map((stat, i) => (
          <motion.div 
            key={i}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.1 }}
            className="bg-zinc-900/50 border border-white/5 p-6 rounded-2xl hover:border-white/20 transition-all group"
          >
            <div className={`w-10 h-10 ${stat.color} rounded-xl flex items-center justify-center mb-4 group-hover:scale-110 transition-transform`}>
              <stat.icon size={20} />
            </div>
            <div className="text-2xl font-black text-white">{stat.value}</div>
            <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">{stat.label}</div>
          </motion.div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Ranking Section */}
        <div className="lg:col-span-1 bg-gradient-to-br from-ubViolet/20 to-transparent border border-ubViolet/20 p-8 rounded-3xl relative overflow-hidden group">
          <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
            <Award size={120} />
          </div>
          <h3 className="text-xl font-bold text-white mb-6 flex items-center gap-2">
            <Star className="text-ubLime" size={20} /> Club Ranking
          </h3>
          <div className="flex items-baseline gap-2 mb-2">
            <span className="text-6xl font-black text-white">{organizerData.ranking}</span>
            <span className="text-gray-400 font-bold text-xl uppercase tracking-widest">In Institute</span>
          </div>
          <p className="text-gray-400 text-sm leading-relaxed mb-6">
            You are in the top 5% of event organizers at {organizerData.institute}.
          </p>
          <div className="space-y-4">
            {organizerData.metrics.map((m, i) => (
              <div key={i} className="flex justify-between items-center bg-white/5 p-3 rounded-xl">
                <span className="text-sm text-gray-300 font-medium">{m.label}</span>
                <span className={`font-bold ${m.color}`}>{m.value}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Recent Events */}
        <div className="lg:col-span-2 bg-zinc-900/30 border border-white/5 p-8 rounded-3xl">
          <div className="flex justify-between items-center mb-8">
            <h3 className="text-xl font-bold text-white">Execution History</h3>
            <button className="text-ubLime text-sm font-bold flex items-center gap-1 hover:underline">
              View All <ArrowRight size={14} />
            </button>
          </div>
          <div className="space-y-4">
            {organizerData.recentEvents.map((event, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-white/5 border border-white/5 rounded-2xl hover:bg-white/10 transition-colors">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-ubBlack rounded-xl border border-white/10 flex items-center justify-center">
                    <Zap className="text-ubViolet" size={20} />
                  </div>
                  <div>
                    <h4 className="text-white font-bold">{event.name}</h4>
                    <p className="text-xs text-gray-500 font-medium">{event.date}</p>
                  </div>
                </div>
                <div className="flex items-center gap-6">
                  <div className="text-right hidden sm:block">
                    <div className="text-sm font-bold text-white">{event.attendees}</div>
                    <div className="text-[10px] text-gray-500 uppercase font-black">Attendees</div>
                  </div>
                  <div className="px-3 py-1 bg-ubLime/10 text-ubLime text-[10px] font-bold rounded-full border border-ubLime/20">
                    {event.status}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );

  const renderSponsorProfile = () => (
    <div className="space-y-8">
      {/* Stats Grid */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Total Invested", value: sponsorData.totalSpent, icon: DollarSign, color: "bg-cyan-400/20 text-cyan-400" },
          { label: "Events Sponsored", value: sponsorData.eventsSponsored, icon: Megaphone, color: "bg-ubViolet/20 text-ubViolet" },
          { label: "Total Reach", value: sponsorData.reachImpressions, icon: Users, color: "bg-ubLime/20 text-ubLime" },
          { label: "Brand Health", value: sponsorData.brandHealth, icon: Shield, color: "bg-pink-400/20 text-pink-400" }
        ].map((stat, i) => (
          <motion.div 
            key={i}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.1 }}
            className="bg-zinc-900/50 border border-white/5 p-6 rounded-2xl hover:border-white/20 transition-all"
          >
            <div className={`w-10 h-10 ${stat.color} rounded-xl flex items-center justify-center mb-4`}>
              <stat.icon size={20} />
            </div>
            <div className="text-2xl font-black text-white">{stat.value}</div>
            <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">{stat.label}</div>
          </motion.div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Performance Metrics */}
        <div className="bg-zinc-900/30 border border-white/5 p-8 rounded-3xl">
          <h3 className="text-xl font-bold text-white mb-6">Marketing Performance</h3>
          <div className="space-y-6">
            {sponsorData.metrics.map((m, i) => (
              <div key={i} className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400 font-medium">{m.label}</span>
                  <span className={`font-black ${m.color}`}>{m.value}</span>
                </div>
                <div className="w-full h-1.5 bg-white/5 rounded-full overflow-hidden">
                  <motion.div 
                    initial={{ width: 0 }}
                    animate={{ width: "70%" }} 
                    transition={{ duration: 1, delay: i * 0.2 }}
                    className={`h-full ${m.color.replace('text-', 'bg-')}`}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Active Sponsorships */}
        <div className="bg-zinc-900/30 border border-white/5 p-8 rounded-3xl">
          <h3 className="text-xl font-bold text-white mb-6">Current Portfolio</h3>
          <div className="space-y-4">
            {sponsorData.activeSponsorships.map((item, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-white/5 border border-white/5 rounded-2xl">
                <div>
                  <h4 className="text-white font-bold">{item.event}</h4>
                  <p className="text-xs text-ubLime font-bold">{item.budget}</p>
                </div>
                <span className="px-3 py-1 bg-white/10 text-white text-[10px] font-bold rounded-full">
                  {item.status}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );

  const renderCorporateProfile = () => (
    <div className="space-y-8">
      {/* Stats Grid */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: "Total Hires", value: corporateData.hires, icon: User, color: "bg-ubViolet/20 text-ubViolet" },
          { label: "Internships", value: corporateData.internships, icon: Briefcase, color: "bg-ubLime/20 text-ubLime" },
          { label: "Hackathons", value: corporateData.hackathonsHosted, icon: Target, color: "bg-cyan-400/20 text-cyan-400" },
          { label: "Talent Score", value: corporateData.talentQuality, icon: Award, color: "bg-pink-400/20 text-pink-400" }
        ].map((stat, i) => (
          <motion.div 
            key={i}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.1 }}
            className="bg-zinc-900/50 border border-white/5 p-6 rounded-2xl hover:border-white/20 transition-all"
          >
            <div className={`w-10 h-10 ${stat.color} rounded-xl flex items-center justify-center mb-4`}>
              <stat.icon size={20} />
            </div>
            <div className="text-2xl font-black text-white">{stat.value}</div>
            <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">{stat.label}</div>
          </motion.div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Recruitment funnel */}
          <div className="bg-zinc-900/30 border border-white/5 p-8 rounded-3xl">
          <h3 className="text-xl font-bold text-white mb-6">Recruitment Funnel</h3>
          <div className="space-y-4">
            {corporateData.metrics.map((m, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-white/5 rounded-2xl">
                <span className="text-gray-400 font-bold uppercase text-xs tracking-widest">{m.label}</span>
                <span className={`text-xl font-black ${m.color}`}>{m.value}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Talent Engagements */}
        <div className="bg-zinc-900/30 border border-white/5 p-8 rounded-3xl">
          <h3 className="text-xl font-bold text-white mb-6">Recent Talent Engagements</h3>
          <div className="space-y-4">
            {corporateData.engagements.map((eng, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-white/5 border border-white/5 rounded-2xl">
                <div>
                  <h4 className="text-white font-bold">{eng.name}</h4>
                  <p className="text-xs text-gray-500">{eng.type}</p>
                </div>
                <div className="text-right">
                  <div className="text-sm font-bold text-ubLime">{eng.candidates}</div>
                  <div className="text-[10px] text-gray-500 uppercase font-black">Candidates</div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );

  return (
    <div className="min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black">
      <Navbar />

      <div className="pt-32 pb-20 px-6 md:px-10 max-w-7xl mx-auto">
        {/* Profile Header */}
        <div className="relative mb-24 mt-4 flex flex-col items-center">
          {/* Background Typography - Now Relative Header */}
          <div className="w-full text-center z-0 pointer-events-none select-none mb-4">
             <motion.h2 
                initial={{ opacity: 0, y: -20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 1, ease: "easeOut" }}
                className="text-[12vw] font-black leading-none text-transparent bg-clip-text bg-gradient-to-r from-ubLime via-white to-ubViolet animate-gradient-x opacity-80 whitespace-nowrap" 
                style={{
                  WebkitTextStroke: "2px rgba(198, 255, 51, 0.3)", // Lime stroke
                }}
             >
                 VIBE-CHECK
             </motion.h2>
          </div>

          <div className="relative z-10 flex flex-col md:flex-row items-end gap-6 px-8 max-w-5xl w-full">
            <div className="relative">
              <div className="w-32 h-32 rounded-3xl p-1 bg-gradient-to-br from-ubLime to-ubViolet border-4 border-black overflow-hidden shadow-2xl">
                <img 
                  src={getProfileImage()} 
                  alt="Profile" 
                  className="w-full h-full object-cover rounded-2xl bg-zinc-800"
                />
              </div>
              <div className="absolute -bottom-2 -right-2 bg-ubLime text-black p-2 rounded-xl border-4 border-black">
                <Zap size={20} fill="black" />
              </div>
            </div>

            <div className="pb-2">
              <div className="flex items-center gap-3">
                <h1 className="text-4xl md:text-5xl font-black tracking-tighter text-white">
                  {currentUser?.name || "Demo User"}
                </h1>
              </div>
              <div className="flex flex-wrap gap-4 mt-3">
                <div className="flex items-center gap-1.5 text-gray-400 text-sm font-medium">
                  <Mail size={16} /> demo@unibuzz.com
                </div>
                <div className="flex items-center gap-1.5 text-gray-400 text-sm font-medium">
                  <MapPin size={16} /> Mumbai, India
                </div>
                <div className="flex items-center gap-1.5 text-gray-400 text-sm font-medium">
                  <Globe size={16} /> alpha.edu.in
                </div>
              </div>
            </div>
            
            <div className="ml-auto hidden md:flex gap-3 mb-2">
              <button className="px-6 py-3 bg-white text-black font-bold rounded-xl hover:bg-ubLime transition-all flex items-center gap-2 shadow-xl">
                <BarChart2 size={18} /> Download Report
              </button>
              <button className="px-6 py-3 bg-zinc-800 border border-white/10 text-white font-bold rounded-xl hover:bg-zinc-700 transition-all flex items-center gap-2">
                <ExternalLink size={18} /> Public Page
              </button>
            </div>
          </div>
        </div>

        {/* Bio Section */}
        <div className="relative mt-12 p-8 md:p-12 rounded-[3rem] bg-[#0A0A0A] border border-white/5 overflow-hidden shadow-[0_0_100px_rgba(0,0,0,0.8)]">
           {/* Animated Background Elements */}
           <div className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.02)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.02)_1px,transparent_1px)] bg-[size:40px_40px] pointer-events-none opacity-40" />
           <div className="absolute -top-40 -right-40 w-[500px] h-[500px] bg-ubViolet/20 rounded-full blur-[120px] pointer-events-none animate-pulse-slow mix-blend-screen" />
           <div className="absolute -bottom-40 -left-40 w-[500px] h-[500px] bg-ubLime/10 rounded-full blur-[120px] pointer-events-none animate-pulse-slow mix-blend-screen" />
           
           <div className="relative z-10 grid grid-cols-1 lg:grid-cols-3 gap-12">
          <div className="lg:col-span-1 border-r border-white/5 pr-8 hidden lg:block">
            <h3 className="text-gray-500 text-xs font-black uppercase tracking-[0.2em] mb-4">Biography</h3>
            <p className="text-gray-400 leading-relaxed font-medium">
              Passionate about creating seamless connection between campus talent and industry opportunities. 
              Top performer in the Mumbai region for technical event coordination.
            </p>
            
            <div className="mt-8 space-y-6">
              <div>
                <h4 className="text-white font-bold mb-3">Key Focus Areas</h4>
                <div className="flex flex-wrap gap-2">
                  {['Event Tech', 'Recruitment', 'Marketing'].map(tag => (
                    <span key={tag} className="px-3 py-1 bg-white/5 border border-white/10 rounded-lg text-[10px] font-bold text-gray-400 uppercase tracking-widest">
                      {tag}
                    </span>
                  ))}
                </div>
              </div>
              
              <div>
                <h4 className="text-white font-bold mb-3">Recent Badges</h4>
                <div className="flex gap-3">
                  <div className="w-10 h-10 bg-ubViolet/20 rounded-lg flex items-center justify-center text-ubViolet border border-ubViolet/30">
                    <Award size={20} />
                  </div>
                  <div className="w-10 h-10 bg-ubLime/20 rounded-lg flex items-center justify-center text-ubLime border border-ubLime/30">
                    <Star size={20} />
                  </div>
                  <div className="w-10 h-10 bg-cyan-400/20 rounded-lg flex items-center justify-center text-cyan-400 border border-cyan-400/30">
                    <Zap size={20} />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="lg:col-span-2">
            <div className="mb-8">
              <h2 className="text-2xl font-black mb-2 text-white">Advanced Insights</h2>
              <p className="text-gray-500 text-sm font-medium">Real-time performance analytics for your role.</p>
            </div>

            {/* Dynamic Content based on User Type */}
            {currentUser?.type === 'sponsor' ? renderSponsorProfile() : 
             currentUser?.type === 'corporate' ? renderCorporateProfile() : 
             renderOrganizerProfile()}
          </div>
        </div>
      </div>
      </div>
    </div>
  );
};

export default ProfilePage;
