import React, { useRef } from 'react';
import Navbar from '../home/Navbar';
import { motion, useScroll, useTransform } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
  BarChart3, 
  FileSpreadsheet, 
  Wallet, 
  Award, 
  Activity, 
  ArrowRight,
  Zap
} from 'lucide-react';

const FeatureCard = ({ title, description, icon: Icon, link, color, index }) => {
  const navigate = useNavigate();
  
  return (
    <motion.div 
      initial={{ opacity: 0, y: 50 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-100px" }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
      className="group relative w-full md:w-[48%] lg:w-[32%] min-h-[400px] mb-8"
      onClick={() => navigate(link)}
    >
      <div className={`absolute inset-0 bg-gradient-to-br ${color} opacity-0 group-hover:opacity-10 transition-opacity duration-500 rounded-3xl blur-xl`} />
      
      <div className="relative h-full bg-zinc-900/50 backdrop-blur-sm border border-zinc-800 hover:border-zinc-700 p-8 rounded-3xl transition-all duration-300 hover:transform hover:-translate-y-2 cursor-pointer flex flex-col justify-between overflow-hidden">
        {/* Hover Gradient Overlay */}
        <div className={`absolute inset-0 bg-gradient-to-br ${color} opacity-0 group-hover:opacity-5 transition-opacity duration-500`} />
        
        {/* Content */}
        <div>
          <div className="mb-8 inline-flex p-4 rounded-2xl bg-zinc-800/50 group-hover:bg-zinc-800 transition-colors">
            <Icon className="w-8 h-8 text-white" />
          </div>
          
          <h3 className="text-3xl font-bold mb-4 text-white leading-tight">
            {title}
          </h3>
          
          <p className="text-zinc-400 text-lg leading-relaxed">
            {description}
          </p>
        </div>

        {/* Bottom Actions */}
        <div className="mt-8 flex items-center justify-between">
          <span className="text-sm font-medium text-zinc-500 group-hover:text-white transition-colors">
            LAUNCH TOOL
          </span>
          <div className="w-10 h-10 rounded-full bg-zinc-800 flex items-center justify-center group-hover:bg-white group-hover:text-black transition-all duration-300">
            <ArrowRight className="w-5 h-5 -rotate-45 group-hover:rotate-0 transition-transform duration-300" />
          </div>
        </div>

        {/* Decorative background numbers */}
        <div className="absolute -bottom-4 -right-4 text-9xl font-bold text-zinc-900/40 select-none pointer-events-none">
          0{index + 1}
        </div>
      </div>
    </motion.div>
  );
};

const FeaturesPage = () => {
  const containerRef = useRef(null);
  const { scrollYProgress } = useScroll({ target: containerRef });
  const y = useTransform(scrollYProgress, [0, 1], [0, -50]);

  const features = [
    {
      title: "Live Lifecycle Deck",
      description: "Mission control for your operational heartbeat. Track registrations, approvals, and live status in real-time.",
      icon: Activity,
      link: "/features/live-lifecycle",
      color: "from-blue-500 to-cyan-500"
    },
    {
      title: "Auto-Report Generator",
      description: "Gen-Z style post-event analytics. Turn boring data into hype-worthy visual stories.",
      icon: BarChart3,
      link: "/features/report-generator",
      color: "from-purple-500 to-pink-500"
    },
    {
      title: "Finance Vault",
      description: "Secure bill submission and transparent ledger tracking. Keep finances crystal clear.",
      icon: Wallet,
      link: "/features/finance-hub",
      color: "from-emerald-500 to-green-500"
    },
    {
      title: "Smart Cert Studio",
      description: "Automated, branded certificates delivered instantly to participants. Zero friction.",
      icon: Award,
      link: "/features/smart-certificates",
      color: "from-yellow-500 to-orange-500"
    },
    {
      title: "CSV Intelligence",
      description: "Data alchemy for your spreadsheets. Sort, filter, and export participant data with AI logic.",
      icon: FileSpreadsheet,
      link: "/features/csv-intelligence",
      color: "from-red-500 to-rose-500"
    }
  ];

  return (
    <div className="min-h-screen bg-black text-white selection:bg-purple-500/30">
      <Navbar />
      
      {/* Hero Section */}
      <div className="relative pt-32 pb-20 px-6 overflow-hidden">
        <div className="absolute top-0 left-0 w-full h-full overflow-hidden z-0">
          <div className="absolute top-[-10%] right-[-5%] w-[500px] h-[500px] bg-purple-600/20 rounded-full blur-[120px]" />
          <div className="absolute bottom-[-10%] left-[-10%] w-[600px] h-[600px] bg-blue-600/10 rounded-full blur-[120px]" />
        </div>

        <div className="container mx-auto relative z-10">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            className="max-w-4xl"
          >
            <div className="flex items-center gap-3 mb-6">
              <span className="px-3 py-1 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-400 text-sm font-medium flex items-center gap-2">
                <Zap className="w-4 h-4" />
                ORGANIZER SUITE v2.0
              </span>
            </div>
            
            <h1 className="text-7xl md:text-8xl font-black mb-8 leading-tight tracking-tight">
              The <span className="text-transparent bg-clip-text bg-gradient-to-r from-white to-zinc-500">Arsenal</span> for <br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-600">Legendary Events.</span>
            </h1>
            
            <p className="text-xl md:text-2xl text-zinc-400 max-w-2xl leading-relaxed">
              Forget spreadsheets and chaos. Access a suite of next-gen tools designed to streamline your workflow and amplify your impact.
            </p>
          </motion.div>
        </div>
      </div>

      {/* Control Deck Grid */}
      <div className="container mx-auto px-6 pb-32 relative z-10" ref={containerRef}>
        <div className="flex flex-wrap gap-6 justify-center">
          {features.map((feature, index) => (
            <FeatureCard 
              key={index}
              index={index}
              {...feature}
            />
          ))}
          
          {/* Coming Soon Card */}
          <motion.div 
            initial={{ opacity: 0, y: 50 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: 0.5 }}
            className="w-full md:w-[48%] lg:w-[32%] min-h-[400px] mb-8 flex flex-col items-center justify-center border border-dashed border-zinc-800 rounded-3xl p-8 bg-zinc-900/20"
          >
            <div className="text-zinc-600 mb-4">
              <Zap className="w-12 h-12" />
            </div>
            <h3 className="text-xl font-bold text-zinc-500 mb-2">More Coming Soon</h3>
            <p className="text-zinc-600 text-center">We are constantly building new tools for the ecosystem.</p>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default FeaturesPage;
