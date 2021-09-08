#=

script version of bellhop_vs_raysolver.jl

=#

using UnderwaterAcoustics
using Plots

fig_suff = "figs/bell_vs_ray_"

### define sound speed profile

# Munk profile
# https://oalib-acoustics.org/AcousticsToolbox/manual/node8.html
z_tilde(z) = 2*(z-1300)/1300
munk_ssp(z) = 1500. * (1 + 0.00737 * (z_tilde(z) - 1 + exp(-z_tilde(z))) )
z_ssp = 0.0:100.0:4000.0

env = UnderwaterEnvironment(
         seasurface = Vacuum,
         seabed = SandyClay,
         ssp = SampledSSP(z_ssp, [munk_ssp(_z) for _z in z_ssp], :smooth),
         bathymetry = ConstantDepth(4000.0)
       )

plot(ssp(env))
png(fig_suff*"ssp")

### set up models & source

min_angle, max_angle = -π/2*0.9, π/2*0.9
pm_bell = Bellhop(env, 100, min_angle, max_angle, true, false);
pm_ray = RaySolver(env; nbeams=100, minangle=min_angle, maxangle=max_angle);

tx = AcousticSource(0.0, -1300.0, 3000.0)

### transmission loss

nx, nz = 600, 500
rx = AcousticReceiverGrid2D(1.0, 20000/nx, nx, -4000.0, 4000/nz, nz);

x_bell = transmissionloss(pm_bell, tx, rx, mode=:coherent);
x_ray = transmissionloss(pm_ray, tx, rx, mode=:coherent);

# plot raw transmissionloss, visual agreement

clims = (-150, -30)
plot(env; receivers=rx, transmissionloss=x_bell, clim=clims)
png(fig_suff*"tloss_bell")

plot(env; receivers=rx, transmissionloss=x_ray, clim=clims)
png(fig_suff*"tloss_ray")

# plot difference

plot(env; receivers=rx, transmissionloss=x_bell - x_ray, clim=(-20, 20))
png(fig_suff*"tloss_diff")


### Rays

rx1D = AcousticReceiver(20000.0, -1300.0)
r_bell = eigenrays(pm_bell, tx, rx1D)
r_ray = eigenrays(pm_ray, tx, rx1D)

plot(env; sources=[tx], receivers=[rx1D], rays=r_bell)
png(fig_suff*"rays_bell")
plot(env; sources=[tx], receivers=[rx1D], rays=r_ray)
png(fig_suff*"rays_ray")

### Arrivals

a_bell = arrivals(pm_bell, tx, rx1D)
a_ray = arrivals(pm_ray, tx, rx1D)

plot(abs.(impulseresponse(a_bell, 44100; reltime=true)); xlabel="Sample #", label="bell")
# line below crashes because of no signal arrival
plot!(abs.(impulseresponse(a_ray, 44100; reltime=true)); label="ray")
png(fig_suff*"arrivals")
