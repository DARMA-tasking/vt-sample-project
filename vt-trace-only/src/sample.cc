#include <mpi.h>
#include <vt/trace/trace_lite.h>

void doWork(MPI_Comm comm) {
  // Find out rank, size
  int world_rank;
  MPI_Comm_rank(comm, &world_rank);
  int world_size;
  MPI_Comm_size(comm, &world_size);

  int number;
  if (world_rank == 0) {
    number = -1;
    MPI_Send(&number, 1, MPI_INT, 1, 0, comm);
  } else if (world_rank == 1) {
    MPI_Recv(&number, 1, MPI_INT, 0, 0, comm, MPI_STATUS_IGNORE);
    fmt::print("{}{}: number={}\n", vt_print_colorize, world_rank, number);
  }
}

int main(int argc, char **argv) {
  MPI_Init(&argc, &argv);

  ::vt::trace::TraceLite myTrace("TestApp");

  myTrace.initializeStandalone(MPI_COMM_WORLD);

  doWork(MPI_COMM_WORLD);

  myTrace.flushTracesFile();
  myTrace.finalizeStandalone();
  MPI_Finalize();
}
