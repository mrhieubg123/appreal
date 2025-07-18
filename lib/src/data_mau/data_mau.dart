dynamic api_machine_status = {
  "data": [
    {
      "line": "GEN3",
      "location": "11",
      "machine_name": "Gap VI Automatically visual inspection Gap",
      "status": "RUN",
    },
    {
      "line": "GEN3",
      "location": "16",
      "machine_name": "A70 Final check Test RF-OTA & final check",
      "status": "ERROR",
    },
    {
      "line": "GEN3",
      "location": "4",
      "machine_name": "A10-1 Check Wifi housing input into JIG",
      "status": "ERROR",
    },
    {
      "line": "GEN3",
      "location": "8",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN2",
      "location": "1",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "2",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "7",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "8",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "RUN",
    },
    {
      "line": "GEN1",
      "location": "9",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "RUN",
    },
    {
      "line": "GEN1",
      "location": "10",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "11",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "12",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "RUN",
    },
    {
      "line": "GEN1",
      "location": "13",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN1",
      "location": "1",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
    {
      "line": "GEN4",
      "location": "1",
      "machine_name": "A40 Assembly Heat spreader to Rear housing",
      "status": "ERROR",
    },
  ],
};

dynamic api_dashboard_error_example = {
  "data": [
    {"count": 4, "error_code": "G0012", "percentage": 36.36},
    {"count": 4, "error_code": "G0014", "percentage": 36.36},
    {"count": 3, "error_code": "G0015", "percentage": 27.27},
  ],
};

dynamic getErrorDetail_example = {
  "data": [
    {
      "cause": "Xylanh không đi hết hành trình",
      "error_id": 27,
      "error_name": "Bất thường xylanh/Cylinder error",
      "solution": "Kiểm tra van, khí, đế van...",
      "used_count": 3,
    },
    {
      "cause": "Xylanh không đi hết hành trình",
      "error_id": 27,
      "error_name": "Bất thường xylanh/Cylinder error",
      "solution": "Kiểm tra cảm biến...",
      "used_count": 3,
    },
    {
      "cause": "Cảm biến xylanh không hoạt động",
      "error_id": 28,
      "error_name": "Bất thường xylanh/Cylinder error",
      "solution": "Kiểm tra cảm biến hoặc từ trong xylanh...",
      "used_count": 2,
    },
  ],
};

dynamic getListConfirm_example = {
  "data": [
    {
      "error_code": "G0014",
      "error_name": "Gắp lỗi/Picking error",
      "error_type": "Gắp lỗi/Picking error",
      "id": 318,
      "line": "GEN3",
      "location": "11",
      "machine_name": "Gap VI Automatically visual inspecttion Gap",
      "machine_type": "XY Machine",
      "runtime_min": 4586,
      "start_time": "2025-07-15 08:44:11",
      "status": "ERROR",
    },
    {
      "error_code": "G0015",
      "error_name": "Rơi liệu/ Material drop",
      "error_type": "Rơi liệu/ Material drop",
      "id": 314,
      "line": "GEN3",
      "location": "11",
      "machine_name": "Gap VI Automatically visual inspecttion Gap",
      "machine_type": "XY Machine",
      "runtime_min": 4466,
      "start_time": "2025-07-15 10:44:13",
      "status": "ERROR",
    },
    {
      "error_code": "G0015",
      "error_name": "Rơi liệu/ Material drop",
      "error_type": "Rơi liệu/ Material drop",
      "id": 319,
      "line": "GEN3",
      "location": "11",
      "machine_name": "Gap VI Automatically visual inspecttion Gap",
      "machine_type": "XY Machine",
      "runtime_min": 4344,
      "start_time": "2025-07-15 12:46:13",
      "status": "ERROR",
    },
  ],
};
dynamic getErrorByCode_example = {
  "error_list": [
    {
      "cause": "Xylanh không đi hết hành trình",
      "error_code": "G0012",
      "error_name": "Bất thường xylanh/Cylinder error",
      "id": 27,
      "solution": "Kiểm tra van, khí, đế van...",
    },
    {
      "cause": "Cảm biến xylanh không hoạt động",
      "error_code": "G0012",
      "error_name": "Bất thường xylanh/Cylinder error",
      "id": 28,
      "solution": "Kiểm tra cảm biến hoặc từ trong xylanh...",
    },
  ],
  "idconfirm": 14,
};
