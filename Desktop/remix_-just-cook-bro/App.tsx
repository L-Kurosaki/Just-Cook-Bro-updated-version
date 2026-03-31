export default function App() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100 p-4">
      <div className="bg-white p-8 rounded-lg shadow-md max-w-2xl w-full text-center">
        <h1 className="text-3xl font-bold mb-4 text-orange-600">Just Cook Bro</h1>
        <p className="text-gray-600 mb-6">
          Welcome back to the React Web version! We are setting up your new architecture:
        </p>
        
        <div className="text-left space-y-4">
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-100">
            <h2 className="font-semibold text-blue-800">1. Multi-Key AI Architecture</h2>
            <p className="text-sm text-blue-600">Different API keys for different modules (Vision, Recipes, Chat) to balance token usage and rate limits.</p>
          </div>
          
          <div className="p-4 bg-green-50 rounded-lg border border-green-100">
            <h2 className="font-semibold text-green-800">2. Recurring Subscriptions</h2>
            <p className="text-sm text-green-600">Moving away from lifetime deals to real monthly/yearly intervals using Stripe (Web) or RevenueCat (Mobile).</p>
          </div>

          <div className="p-4 bg-purple-50 rounded-lg border border-purple-100">
            <h2 className="font-semibold text-purple-800">3. Google Play Publishing</h2>
            <p className="text-sm text-purple-600">Ready to be exported to GitHub and wrapped with Capacitor for the Google Play Store.</p>
          </div>
        </div>
      </div>
    </div>
  );
}