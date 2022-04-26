local solver = {}
local EMPTY_VECTOR = Vector3.new()

function solver:Solve(point)
    local originBone = point.Instances[1]
    local vector = point.Instances[2]
    local worldCFrame = originBone.TransformedWorldCFrame
    local pointToWorldSpace = worldCFrame.Position + worldCFrame:VectorToWorldSpace(vector)

    if not point.LastPosition then
        point.LastPosition = pointToWorldSpace
    end

    local origin = point.LastPosition
    local direction = pointToWorldSpace - (point.LastPosition or EMPTY_VECTOR)

    point.WorldSpace = pointToWorldSpace

    return origin, direction
end
function solver:UpdateToNextPosition(point)
    return point.WorldSpace
end
function solver:Visualize(point)
    return CFrame.lookAt(point.WorldSpace, point.LastPosition)
end

return solver
