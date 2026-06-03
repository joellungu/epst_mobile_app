(function () {
  const channel = window.ScormBridge;
  const state = Object.assign(
    {
      "cmi.core.lesson_status": "not attempted",
      "cmi.core.score.raw": "",
      "cmi.core.score.min": "",
      "cmi.core.score.max": "",
      "cmi.core.lesson_location": "",
      "cmi.core.session_time": "",
      "cmi.core.total_time": "0000:00:00.00",
      "cmi.core.student_name": "Professeur",
      "cmi.core.student_id": "local-professeur",
      "cmi.completion_status": "unknown",
      "cmi.success_status": "unknown",
      "cmi.progress_measure": "",
      "cmi.score.raw": "",
      "cmi.score.min": "",
      "cmi.score.max": "",
      "cmi.location": "",
      "cmi.session_time": "",
      "cmi.total_time": "PT0H0M0S",
      "cmi.learner_name": "Professeur",
      "cmi.learner_id": "local-professeur"
    },
    window.__SCORM_INITIAL_DATA__ || {}
  );

  let initialized = false;
  let lastError = "0";

  function post(type, payload) {
    if (!channel || !channel.postMessage) return;
    channel.postMessage(JSON.stringify({ type, payload, at: new Date().toISOString() }));
  }

  function syncProgress() {
    const rawScore = state["cmi.core.score.raw"] || state["cmi.score.raw"] || "";
    const status = firstMeaningfulStatus(
      state["cmi.completion_status"],
      state["cmi.core.lesson_status"],
      state["cmi.success_status"]
    );
    const progressMeasure = state["cmi.progress_measure"] || "";
    const location = state["cmi.core.lesson_location"] || state["cmi.location"] || "";
    const progress = {
      status,
      score: rawScore,
      progressMeasure,
      location,
      data: state
    };
    post("progress", progress);
  }

  function normalizeValue(value) {
    if (value === undefined || value === null) return "";
    return String(value);
  }

  function firstMeaningfulStatus() {
    for (let i = 0; i < arguments.length; i += 1) {
      const value = normalizeValue(arguments[i]).toLowerCase();
      if (value && value !== "unknown" && value !== "not attempted") {
        return normalizeValue(arguments[i]);
      }
    }
    return "not attempted";
  }

  window.API = {
    LMSInitialize: function () {
      initialized = true;
      lastError = "0";
      post("initialized", state);
      return "true";
    },
    LMSFinish: function () {
      initialized = false;
      lastError = "0";
      syncProgress();
      post("finished", state);
      return "true";
    },
    LMSGetValue: function (key) {
      lastError = "0";
      return normalizeValue(state[key]);
    },
    LMSSetValue: function (key, value) {
      state[key] = normalizeValue(value);
      lastError = "0";
      syncProgress();
      return "true";
    },
    LMSCommit: function () {
      lastError = "0";
      syncProgress();
      return "true";
    },
    LMSGetLastError: function () {
      return lastError;
    },
    LMSGetErrorString: function (code) {
      return code === "0" ? "No error" : "SCORM local runtime error";
    },
    LMSGetDiagnostic: function () {
      return "";
    }
  };

  window.API_1484_11 = {
    Initialize: function () {
      initialized = true;
      lastError = "0";
      post("initialized", state);
      return "true";
    },
    Terminate: function () {
      initialized = false;
      lastError = "0";
      syncProgress();
      post("finished", state);
      return "true";
    },
    GetValue: function (key) {
      lastError = "0";
      return normalizeValue(state[key]);
    },
    SetValue: function (key, value) {
      state[key] = normalizeValue(value);
      lastError = "0";
      syncProgress();
      return "true";
    },
    Commit: function () {
      lastError = "0";
      syncProgress();
      return "true";
    },
    GetLastError: function () {
      return lastError;
    },
    GetErrorString: function (code) {
      return code === "0" ? "No error" : "SCORM local runtime error";
    },
    GetDiagnostic: function () {
      return "";
    }
  };

  window.scormAgainLocalRuntime = {
    initialized: function () {
      return initialized;
    },
    dump: function () {
      return Object.assign({}, state);
    }
  };

  post("ready", state);
})();
