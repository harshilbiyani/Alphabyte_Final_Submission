import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
    X, Award, Sparkles, Eye, Download, Edit3, Copy,
    CheckCircle2, Star, Zap, Layout, FileText, Trophy,
    Briefcase, GraduationCap, Music, Code, Palette
} from 'lucide-react';

const CertificateTemplates = ({ onClose }) => {
    const [selectedTemplate, setSelectedTemplate] = useState(null);
    const [previewMode, setPreviewMode] = useState(false);
    const [customizing, setCustomizing] = useState(false);

    const templates = [
        {
            id: 'modern_workshop',
            name: 'Modern Workshop',
            category: 'Workshop',
            icon: Code,
            color: 'ubLime',
            bgGradient: 'from-ubLime/20 to-cyan-400/20',
            description: 'Clean, modern design perfect for technical workshops',
            features: ['QR Code', 'Blockchain Hash', 'Skill Tags', 'LinkedIn Ready'],
            preview: {
                headerBg: 'bg-ubLime',
                accentColor: 'text-ubLime',
                borderColor: 'border-ubLime/30'
            }
        },
        {
            id: 'hackathon_elite',
            name: 'Hackathon Elite',
            category: 'Hackathon',
            icon: Trophy,
            color: 'yellow-400',
            bgGradient: 'from-yellow-400/20 to-orange-400/20',
            description: 'Bold and energetic design for hackathon winners',
            features: ['Winner Badge', 'Team Info', 'Project Details', 'Achievement Level'],
            preview: {
                headerBg: 'bg-yellow-400',
                accentColor: 'text-yellow-400',
                borderColor: 'border-yellow-400/30'
            }
        },
        {
            id: 'professional_seminar',
            name: 'Professional Seminar',
            category: 'Seminar',
            icon: Briefcase,
            color: 'ubViolet',
            bgGradient: 'from-ubViolet/20 to-purple-400/20',
            description: 'Elegant and professional for seminars and conferences',
            features: ['Speaker Signature', 'CPD Hours', 'Session Details', 'Accreditation'],
            preview: {
                headerBg: 'bg-ubViolet',
                accentColor: 'text-ubViolet',
                borderColor: 'border-ubViolet/30'
            }
        },
        {
            id: 'cultural_vibrant',
            name: 'Cultural Vibrant',
            category: 'Cultural',
            icon: Music,
            color: 'pink-400',
            bgGradient: 'from-pink-400/20 to-purple-400/20',
            description: 'Colorful and vibrant for cultural events',
            features: ['Event Photos', 'Performance Details', 'Category Badge', 'Social Share'],
            preview: {
                headerBg: 'bg-pink-400',
                accentColor: 'text-pink-400',
                borderColor: 'border-pink-400/30'
            }
        },
        {
            id: 'minimalist_clean',
            name: 'Minimalist Clean',
            category: 'General',
            icon: Layout,
            color: 'cyan-400',
            bgGradient: 'from-cyan-400/20 to-blue-400/20',
            description: 'Simple and clean design for any event type',
            features: ['Minimal Design', 'Focus on Content', 'Universal Appeal', 'Easy Customization'],
            preview: {
                headerBg: 'bg-cyan-400',
                accentColor: 'text-cyan-400',
                borderColor: 'border-cyan-400/30'
            }
        },
        {
            id: 'academic_excellence',
            name: 'Academic Excellence',
            category: 'Academic',
            icon: GraduationCap,
            color: 'indigo-400',
            bgGradient: 'from-indigo-400/20 to-blue-400/20',
            description: 'Traditional academic style with modern touches',
            features: ['University Seal', 'Grade Display', 'Course Code', 'Credit Hours'],
            preview: {
                headerBg: 'bg-indigo-400',
                accentColor: 'text-indigo-400',
                borderColor: 'border-indigo-400/30'
            }
        },
        {
            id: 'creative_design',
            name: 'Creative Design',
            category: 'Design',
            icon: Palette,
            color: 'rose-400',
            bgGradient: 'from-rose-400/20 to-pink-400/20',
            description: 'Artistic and creative for design competitions',
            features: ['Portfolio Link', 'Design Preview', 'Judge Comments', 'Award Category'],
            preview: {
                headerBg: 'bg-rose-400',
                accentColor: 'text-rose-400',
                borderColor: 'border-rose-400/30'
            }
        },
        {
            id: 'sports_champion',
            name: 'Sports Champion',
            category: 'Sports',
            icon: Trophy,
            color: 'orange-400',
            bgGradient: 'from-orange-400/20 to-red-400/20',
            description: 'Dynamic design for sports achievements',
            features: ['Medal Display', 'Event Stats', 'Rank Badge', 'Performance Metrics'],
            preview: {
                headerBg: 'bg-orange-400',
                accentColor: 'text-orange-400',
                borderColor: 'border-orange-400/30'
            }
        }
    ];

    const TemplatePreview = ({ template, participant = { name: 'John Doe', role: 'Participant', attendance: 95 } }) => (
        <div className={`relative w-full aspect-[1.414/1] bg-gradient-to-br from-zinc-900 to-black border-4 ${template.preview.borderColor} rounded-3xl p-8 overflow-hidden`}>
            {/* Decorative Background */}
            <div className="absolute inset-0 opacity-5">
                <div className={`absolute top-10 left-10 w-32 h-32 border-4 border-${template.color} rounded-full`} />
                <div className={`absolute bottom-10 right-10 w-40 h-40 border-4 border-${template.color} rounded-full`} />
            </div>

            {/* Header */}
            <div className="relative z-10 text-center mb-6">
                <div className={`w-16 h-16 ${template.preview.headerBg} rounded-2xl flex items-center justify-center mx-auto mb-3`}>
                    <Award size={32} className="text-black" />
                </div>
                <h1 className="text-3xl font-black text-white mb-1">CERTIFICATE</h1>
                <p className={`${template.preview.accentColor} text-sm font-bold uppercase tracking-widest`}>
                    of {template.category === 'Hackathon' ? 'Excellence' : 'Achievement'}
                </p>
            </div>

            {/* Content */}
            <div className="relative z-10 text-center space-y-4">
                <p className="text-gray-400 text-xs uppercase tracking-wider">This is to certify that</p>
                <h2 className={`text-4xl font-black text-transparent bg-clip-text bg-gradient-to-r ${template.bgGradient.replace('from-', 'from-').replace('to-', 'to-').replace('/20', '')}`}>
                    {participant.name}
                </h2>
                <p className="text-gray-400 text-xs">has successfully completed</p>
                <h3 className="text-xl font-bold text-white">Sample Event Title</h3>

                <div className="flex items-center justify-center gap-6 pt-4">
                    <div className="text-center">
                        <p className="text-[8px] text-gray-500 uppercase mb-1">Attendance</p>
                        <p className={`text-lg font-black ${template.preview.accentColor}`}>{participant.attendance}%</p>
                    </div>
                    <div className="w-px h-8 bg-white/10" />
                    <div className="text-center">
                        <p className="text-[8px] text-gray-500 uppercase mb-1">Role</p>
                        <p className="text-lg font-black text-white">{participant.role}</p>
                    </div>
                    <div className="w-px h-8 bg-white/10" />
                    <div className="text-center">
                        <p className="text-[8px] text-gray-500 uppercase mb-1">Date</p>
                        <p className="text-lg font-black text-cyan-400">Oct 2025</p>
                    </div>
                </div>
            </div>

            {/* Footer */}
            <div className="absolute bottom-6 left-8 right-8 flex items-end justify-between">
                <div className="text-left">
                    <div className="w-24 h-px bg-white/20 mb-1" />
                    <p className="text-[8px] text-gray-500">Signature</p>
                </div>
                <div className="text-center">
                    <div className="w-12 h-12 bg-white/10 rounded-lg flex items-center justify-center mb-1">
                        <div className="w-8 h-8 bg-white/20 rounded" />
                    </div>
                    <p className="text-[6px] text-gray-500 uppercase">QR Code</p>
                </div>
                <div className="text-right">
                    <p className="text-[6px] text-gray-500 font-mono mb-1">Hash</p>
                    <p className={`text-[8px] ${template.preview.accentColor} font-mono`}>0x7a8f...</p>
                </div>
            </div>
        </div>
    );

    return (
        <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-[100] flex items-center justify-center px-6 bg-black/90 backdrop-blur-xl overflow-y-auto py-20"
            onClick={onClose}
        >
            <motion.div
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.9, opacity: 0 }}
                onClick={(e) => e.stopPropagation()}
                className="bg-zinc-900 border border-white/10 rounded-[48px] max-w-7xl w-full my-auto"
            >
                {/* Header */}
                <div className="p-8 border-b border-white/10 flex items-center justify-between">
                    <div>
                        <h2 className="text-3xl font-black text-white mb-2">Certificate Templates</h2>
                        <p className="text-gray-400">Choose from our professionally designed templates</p>
                    </div>
                    <button
                        onClick={onClose}
                        className="w-12 h-12 bg-white/5 rounded-xl flex items-center justify-center hover:bg-white/10 transition-all"
                    >
                        <X size={24} className="text-gray-400" />
                    </button>
                </div>

                {/* Content */}
                <div className="p-8 max-h-[70vh] overflow-y-auto">
                    {!previewMode ? (
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            {templates.map((template, i) => (
                                <motion.div
                                    key={template.id}
                                    initial={{ opacity: 0, y: 20 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: i * 0.05 }}
                                    className="group cursor-pointer"
                                    onClick={() => {
                                        setSelectedTemplate(template);
                                        setPreviewMode(true);
                                    }}
                                >
                                    <div className={`relative bg-gradient-to-br ${template.bgGradient} border border-white/10 rounded-3xl p-6 hover:border-${template.color}/50 transition-all overflow-hidden`}>
                                        {/* Template Preview Thumbnail */}
                                        <div className="mb-4 transform group-hover:scale-105 transition-transform">
                                            <div className="aspect-[1.414/1] bg-zinc-900/50 rounded-2xl p-4 border border-white/5">
                                                <div className={`w-full h-8 ${template.preview.headerBg} rounded-lg mb-2 opacity-80`} />
                                                <div className="space-y-2">
                                                    <div className="w-3/4 h-2 bg-white/10 rounded mx-auto" />
                                                    <div className="w-1/2 h-2 bg-white/10 rounded mx-auto" />
                                                    <div className="w-full h-1 bg-white/5 rounded mt-4" />
                                                    <div className="w-full h-1 bg-white/5 rounded" />
                                                </div>
                                            </div>
                                        </div>

                                        {/* Template Info */}
                                        <div className="flex items-start gap-3 mb-3">
                                            <div className={`w-10 h-10 bg-${template.color}/20 rounded-xl flex items-center justify-center flex-shrink-0`}>
                                                <template.icon size={20} className={`text-${template.color}`} />
                                            </div>
                                            <div className="flex-1">
                                                <h3 className="text-white font-bold mb-1">{template.name}</h3>
                                                <p className="text-gray-400 text-xs">{template.description}</p>
                                            </div>
                                        </div>

                                        {/* Features */}
                                        <div className="flex flex-wrap gap-2 mb-4">
                                            {template.features.slice(0, 3).map((feature, idx) => (
                                                <span key={idx} className="px-2 py-1 bg-white/5 rounded-lg text-[10px] text-gray-400 font-medium">
                                                    {feature}
                                                </span>
                                            ))}
                                            {template.features.length > 3 && (
                                                <span className="px-2 py-1 bg-white/5 rounded-lg text-[10px] text-gray-400 font-medium">
                                                    +{template.features.length - 3}
                                                </span>
                                            )}
                                        </div>

                                        {/* Category Badge */}
                                        <span className={`inline-block px-3 py-1 bg-${template.color}/20 text-${template.color} rounded-full text-xs font-bold uppercase`}>
                                            {template.category}
                                        </span>

                                        {/* Hover Overlay */}
                                        <div className="absolute inset-0 bg-black/0 group-hover:bg-black/50 transition-all rounded-3xl flex items-center justify-center opacity-0 group-hover:opacity-100">
                                            <div className="flex gap-3">
                                                <button className="px-4 py-2 bg-white rounded-xl text-black font-bold text-sm flex items-center gap-2">
                                                    <Eye size={16} />
                                                    Preview
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </motion.div>
                            ))}
                        </div>
                    ) : (
                        <div className="space-y-8">
                            {/* Preview Header */}
                            <div className="flex items-center justify-between">
                                <div className="flex items-center gap-4">
                                    <button
                                        onClick={() => setPreviewMode(false)}
                                        className="px-4 py-2 bg-white/5 border border-white/10 rounded-xl text-white font-bold hover:bg-white/10 transition-all"
                                    >
                                        ← Back to Templates
                                    </button>
                                    <div>
                                        <h3 className="text-2xl font-black text-white">{selectedTemplate?.name}</h3>
                                        <p className="text-gray-400 text-sm">{selectedTemplate?.description}</p>
                                    </div>
                                </div>
                                <div className="flex gap-3">
                                    <button className="px-4 py-2 bg-white/5 border border-white/10 rounded-xl text-white font-bold hover:bg-white/10 transition-all flex items-center gap-2">
                                        <Edit3 size={16} />
                                        Customize
                                    </button>
                                    <button className="px-6 py-2 bg-ubLime rounded-xl text-black font-bold hover:bg-ubLime/90 transition-all flex items-center gap-2">
                                        <CheckCircle2 size={16} />
                                        Use Template
                                    </button>
                                </div>
                            </div>

                            {/* Large Preview */}
                            <div className="max-w-3xl mx-auto">
                                <TemplatePreview template={selectedTemplate} />
                            </div>

                            {/* Features List */}
                            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                                {selectedTemplate?.features.map((feature, idx) => (
                                    <div key={idx} className="p-4 bg-white/5 border border-white/5 rounded-2xl text-center">
                                        <CheckCircle2 size={20} className={`text-${selectedTemplate.color} mx-auto mb-2`} />
                                        <p className="text-white text-sm font-bold">{feature}</p>
                                    </div>
                                ))}
                            </div>

                            {/* Customization Options */}
                            <div className="p-6 bg-white/5 border border-white/5 rounded-3xl">
                                <h4 className="text-xl font-black text-white mb-4">Customization Options</h4>
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    <div className="p-4 bg-black/40 rounded-2xl">
                                        <p className="text-gray-400 text-xs uppercase mb-2">Colors</p>
                                        <p className="text-white font-bold">Fully customizable color scheme</p>
                                    </div>
                                    <div className="p-4 bg-black/40 rounded-2xl">
                                        <p className="text-gray-400 text-xs uppercase mb-2">Logo</p>
                                        <p className="text-white font-bold">Add your organization logo</p>
                                    </div>
                                    <div className="p-4 bg-black/40 rounded-2xl">
                                        <p className="text-gray-400 text-xs uppercase mb-2">Fields</p>
                                        <p className="text-white font-bold">Dynamic field customization</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    )}
                </div>

                {/* Footer */}
                {!previewMode && (
                    <div className="p-8 border-t border-white/10 flex items-center justify-between">
                        <p className="text-gray-400">
                            <span className="text-white font-bold">{templates.length}</span> professional templates available
                        </p>
                        <button
                            onClick={onClose}
                            className="px-6 py-3 bg-white/5 border border-white/10 rounded-xl text-white font-bold hover:bg-white/10 transition-all"
                        >
                            Close
                        </button>
                    </div>
                )}
            </motion.div>
        </motion.div>
    );
};

export default CertificateTemplates;
