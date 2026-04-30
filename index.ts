import { coworkerAgent } from './src/mastra/agents/coworker/agent.js';
import { mastra } from './src/mastra/index.js'; // initializes memory, storage, routes, scheduled tasks
import { serve } from '@astropods/adapter-mastra';

void mastra; // ensure side-effects run before serving
serve(coworkerAgent);
