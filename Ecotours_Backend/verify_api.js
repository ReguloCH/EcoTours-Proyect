const axios = require('axios');

async function checkApi() {
    try {
        console.log("Testing GET /api/historial-compras...");
        const res = await axios.get('http://localhost:3000/api/historial-compras');
        console.log("Status:", res.status);
        console.log("Data type:", typeof res.data);
        if (res.data && res.data.data && Array.isArray(res.data.data)) {
            console.log("✅ Data validation passed. Records found:", res.data.data.length);
            if (res.data.data.length > 0) {
                console.log("Sample record:", JSON.stringify(res.data.data[0], null, 2));
            }
        } else {
            console.error("❌ Invalid response structure:", Object.keys(res.data));
        }

        console.log("\nTesting GET /api/usuario...");
        const resUser = await axios.get('http://localhost:3000/api/usuario');
        console.log("Status:", resUser.status);
        console.log("Data is Array?", Array.isArray(resUser.data));
        console.log("✅ Usuario API seems OK");

    } catch (error) {
        console.error("❌ API Request Failed:", error.message);
        if (error.code === 'ECONNREFUSED') {
            console.error("👉 The backend server is NOT running. Please restart it.");
        }
        if (error.response) {
            console.error("Response data:", error.response.data);
        }
    }
}

checkApi();
