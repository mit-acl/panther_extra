Header header

float64 ms_initial_setup
float64 ms_convex_hulls
float64 ms_opt
float64 ms_guess_pos
float64 ms_guess_yaw_search_graph
float64 ms_guess_yaw_fit_poly
float64 ms_total_replan

float64 pos_smooth_cost 
float64 fov_cost 
float64 yaw_smooth_cost 
float64 final_pos_cost
float64 final_yaw_cost

geometry_msgs/Vector3 tracking_now_pos
geometry_msgs/Vector3 tracking_now_vel

bool success_guess_pos 
bool success_guess_yaw 
bool success_opt 
bool success_replanning
string info_replan 
