
# Project Overview

This application consists of four primary servers, each with distinct responsibilities:

### 1. **HTTP Server**
The HTTP server processes incoming HTTP requests and handles specific routes in the `Handler` module. Its functionality includes:  
- Serving static HTML pages.  
- Generating dynamic HTML pages using templates with `Ex.function_from_file`.  
- Providing responses based on hardcoded in-memory data.  
- Acting as an API controller to encode response content into JSON using the `Poison` library.

---

### 2. **Sensor Server**
The Sensor server simulates fetching data from sensors periodically, executing every **7 seconds**.

---

### 3. **Pledge Server**
The Pledge server processes HTTP POST requests related to pledges. It operates as a **long-running, stateful process** using `GenServer` to maintain pledge data as its state.

---

### 4. **Kick Server**
The Kick server starts the HTTP server as a linked process and monitors it. If the HTTP server exits, the Kick server automatically restarts it, functioning similarly to a low-level supervisor.

---

### Supervisors
The application employs two levels of supervision for robust fault tolerance:

1. **Mid Supervisor**  
   - Supervises the Sensor server and Pledge server.  

2. **Main Supervisor**  
   - Supervises the Mid Supervisor and the Kick server.

---
