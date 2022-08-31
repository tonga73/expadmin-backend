import { Module } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { TracingController } from './tracing.controller';
import { TracingService } from './tracing.service';

@Module({
  controllers: [TracingController],
  providers: [PrismaService, TracingService],
  exports: [TracingService],
})
export class TracingModule {}
