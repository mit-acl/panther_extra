Header header

bool replanning_was_needed

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

geometry_msgs/Vector3 pos
geometry_msgs/Vector3 G_term_pos

bool success_guess_pos 
bool success_guess_yaw 
bool success_opt 
bool success_replanning
string info_replan 
string drone_status 

int64 num_of_obstacles
int64 num_LPs_run
float64 mean_time_per_LP_ms