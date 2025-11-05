--- @class Pathfinding Handles pathfinding for units in battle mode
Pathfinding = {
    paths_per_frame = 5, -- Limit paths calculated per frame
    pending_requests = {},
    completed_paths = {}
}