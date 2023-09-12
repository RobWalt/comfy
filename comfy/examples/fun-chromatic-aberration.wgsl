@fragment
fn fs_main(vertex: VertexOutput) -> @location(0) vec4<f32> {
    let uv: vec2<f32> = vertex.tex_coords;

    let dist_from_center: f32 = distance(uv, vec2<f32>(0.5, 0.5));

    let custom_curve = 1.0 - pow(1.0 - dist_from_center, 3.0);

    let vignette_strength: f32 = custom_curve;

    let center_boost: f32 = 0.2; // Change this value to control the minimum aberration at the center

    let off: f32 = (params.chromatic_aberration * vignette_strength + center_boost * params.chromatic_aberration) / params.resolution.x;

    var color: vec3<f32>;

    color.r = textureSample(r_color, r_sampler, vec2<f32>(uv.x - off, uv.y)).r;
    color.g = textureSample(r_color, r_sampler, vec2<f32>(uv.x + off, uv.y)).g;
    color.b = textureSample(r_color, r_sampler, vec2<f32>(uv.x - off, uv.y)).b;

    return vec4<f32>(color, 1.0);
}

