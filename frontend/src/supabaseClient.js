import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://dffnvsnnkzvjpotzrhoz.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRmZm52c25ua3p2anBvdHpyaG96Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1MTk2NzAsImV4cCI6MjA2NjA5NTY3MH0.jUSAZw79RCIAkZ3foARhXC1Lh-4gg7OnFGBaW8T78iQ';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
