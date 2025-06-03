




import Foundation
import Security
import Supabase

@Observable
class DatabaseConnection {
    
    let supabase: SupabaseClient
    
    init() {
        
        self.supabase = SupabaseClient(
          supabaseURL: URL(string: "https://cdflinstlsqdqmzbrvjl.supabase.co")!,
          supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkZmxpbnN0bHNxZHFtemJydmpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5MTAxMjUsImV4cCI6MjA2NDQ4NjEyNX0.wNBhK48Mu629eTuRJJpBXTmxQ1MpKbg0e-_2bQuJUxw"
        )
                
    }
    
    
}

